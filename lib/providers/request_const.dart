import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:flutter/material.dart';
import 'package:miel_work_request_const_web/models/user.dart';
import 'package:miel_work_request_const_web/services/fm.dart';
import 'package:miel_work_request_const_web/services/request_const.dart';
import 'package:miel_work_request_const_web/services/user.dart';
import 'package:path/path.dart' as p;

class RequestConstProvider with ChangeNotifier {
  final RequestConstService _constService = RequestConstService();
  final UserService _userService = UserService();
  final FmService _fmService = FmService();

  Future<String?> check({
    required String companyName,
    required String companyUserName,
    required String companyUserEmail,
    required String companyUserTel,
  }) async {
    String? error;
    if (companyName == '') return '店舗名は必須入力です';
    if (companyUserName == '') return '店舗責任者名は必須入力です';
    if (companyUserEmail == '') return '店舗責任者メールアドレスは必須入力です';
    if (companyUserTel == '') return '店舗責任者電話番号は必須入力です';
    return error;
  }

  Future<String?> create({
    required String companyName,
    required String companyUserName,
    required String companyUserEmail,
    required String companyUserTel,
    required String constName,
    required String constUserName,
    required String constUserTel,
    required DateTime constStartedAt,
    required DateTime constEndedAt,
    required bool constAtPending,
    required PlatformFile? pickedProcessFile,
    required String constContent,
    required bool noise,
    required String noiseMeasures,
    required bool dust,
    required String dustMeasures,
    required bool fire,
    required String fireMeasures,
  }) async {
    String? error;
    if (companyName == '') return '店舗名は必須入力です';
    if (companyUserName == '') return '店舗責任者名は必須入力です';
    if (companyUserEmail == '') return '店舗責任者メールアドレスは必須入力です';
    if (companyUserTel == '') return '店舗責任者電話番号は必須入力です';
    try {
      await FirebaseAuth.instance.signInAnonymously().then((value) async {
        String id = _constService.id();
        String processFile = '';
        String processFileExt = '';
        if (pickedProcessFile != null) {
          String ext = p.extension(pickedProcessFile.name);
          storage.UploadTask uploadTask;
          storage.Reference ref = storage.FirebaseStorage.instance
              .ref()
              .child('requestConst')
              .child('/$id$ext');
          uploadTask = ref.putData(pickedProcessFile.bytes!);
          await uploadTask.whenComplete(() => null);
          processFile = await ref.getDownloadURL();
          processFileExt = ext;
        }
        _constService.create({
          'id': id,
          'companyName': companyName,
          'companyUserName': companyUserName,
          'companyUserEmail': companyUserEmail,
          'companyUserTel': companyUserTel,
          'constName': constName,
          'constUserName': constUserName,
          'constUserTel': constUserTel,
          'constStartedAt': constStartedAt,
          'constEndedAt': constEndedAt,
          'constAtPending': constAtPending,
          'processFile': processFile,
          'processFileExt': processFileExt,
          'constContent': constContent,
          'noise': noise,
          'noiseMeasures': noiseMeasures,
          'dust': dust,
          'dustMeasures': dustMeasures,
          'fire': fire,
          'fireMeasures': fireMeasures,
          'approval': 0,
          'approvedAt': DateTime.now(),
          'approvalUsers': [],
          'createdAt': DateTime.now(),
        });
      });
      //通知
      List<UserModel> sendUsers = [];
      sendUsers = await _userService.selectList();
      if (sendUsers.isNotEmpty) {
        for (UserModel user in sendUsers) {
          _fmService.send(
            token: user.token,
            title: '社外申請',
            body: '店舗工事作業の申請がありました',
          );
        }
      }
    } catch (e) {
      error = '申請に失敗しました';
    }
    return error;
  }
}
