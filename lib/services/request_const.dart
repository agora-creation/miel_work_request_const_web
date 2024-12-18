import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miel_work_request_const_web/models/request_const.dart';

class RequestConstService {
  String collection = 'requestConst';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String id() {
    return firestore.collection(collection).doc().id;
  }

  void create(Map<String, dynamic> values) {
    firestore.collection(collection).doc(values['id']).set(values);
  }

  Future<RequestConstModel?> selectData(String id) async {
    RequestConstModel? ret;
    await firestore.collection(collection).doc(id).get().then((value) {
      ret = RequestConstModel.fromSnapshot(value);
    });
    return ret;
  }
}
