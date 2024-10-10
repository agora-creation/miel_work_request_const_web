import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miel_work_request_const_web/services/fm.dart';
import 'package:miel_work_request_const_web/services/request_const.dart';
import 'package:miel_work_request_const_web/services/user.dart';

class RequestConstProvider with ChangeNotifier {
  final RequestConstService _constService = RequestConstService();
  final UserService _userService = UserService();
  final FmService _fmService = FmService();

  Future<String?> create({
    required String shopName,
    required String shopUserName,
    required String shopUserEmail,
    required String shopUserTel,
    required String remarks,
  }) async {
    String? error;
    if (shopName == '') return '店舗名は必須入力です';
    if (shopUserName == '') return '店舗責任者名は必須入力です';
    if (shopUserEmail == '') return '店舗責任者メールアドレスは必須入力です';
    if (shopUserTel == '') return '店舗責任者電話番号は必須入力です';
    try {
      await FirebaseAuth.instance.signInAnonymously().then((value) {
        String id = _constService.id();
        _constService.create({
          'id': id,
          'shopName': shopName,
          'shopUserName': shopUserName,
          'shopUserEmail': shopUserEmail,
          'shopUserTel': shopUserTel,
          'remarks': remarks,
          'approval': 0,
          'approvedAt': DateTime.now(),
          'approvalUsers': [],
          'createdAt': DateTime.now(),
        });
      });
      //通知
      // List<UserModel> sendUsers = [];
      // sendUsers = await _userService.selectList();
      // if (sendUsers.isNotEmpty) {
      //   for (UserModel user in sendUsers) {
      //     _fmService.send(
      //       token: user.token,
      //       title: '社外申請',
      //       body: '店舗工事作業の申請がありました',
      //     );
      //   }
      // }
    } catch (e) {
      error = '申請に失敗しました';
    }
    return error;
  }
}
