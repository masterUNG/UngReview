// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungreview/models/user_model.dart';
import 'package:ungreview/states/add_product.dart';
import 'package:ungreview/states/authen.dart';
import 'package:ungreview/states/create_account.dart';
import 'package:ungreview/states/my_service_buyer.dart';
import 'package:ungreview/states/my_service_seller.dart';
import 'package:ungreview/utility/get_data_by_uid.dart';
import 'package:ungreview/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  MyConstant.rountAuthen: (context) => const Authen(),
  MyConstant.rountCreateAccount: (context) => const CreateAccount(),
  MyConstant.rountBuyer: (context) => const MyServiceBuyer(),
  MyConstant.rountSeller: (context) => const MyServiceSeller(),
  MyConstant.rountAddProduct: (context) => const AddProduct(),
};

String? firstState;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event == null) {
        firstState = MyConstant.rountAuthen;
        runApp(const MyApp());
      } else {
        String uid = event.uid;
        UserModel? userModel = await GetDataByUid(uid: uid).getUserModel();
        switch (userModel!.typeuser) {
          case 'buyer':
            firstState = MyConstant.rountBuyer;
            runApp(const MyApp());
            break;
          case 'seller':
            firstState = MyConstant.rountSeller;
            runApp(const MyApp());
            break;
          default:
        }
      }
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      title: MyConstant.appName,
      initialRoute: firstState ?? MyConstant.rountAuthen,
    );
  }
}
