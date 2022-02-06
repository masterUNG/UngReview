// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ungreview/models/user_model.dart';

class GetDataByUid {
  final String uid;
  GetDataByUid({
    required this.uid,
  });

  Future<UserModel?> getUserModel() async {
    var result =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();
    UserModel userModel = UserModel.fromMap(result.data()!);
    return userModel;
  }
}
