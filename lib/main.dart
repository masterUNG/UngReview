import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungreview/states/authen.dart';
import 'package:ungreview/states/create_account.dart';
import 'package:ungreview/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  MyConstant.rountAuthen: (context) => const Authen(),
  MyConstant.rountCreateAccount: (context) => const CreateAccount(),
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) => print('####### Firebase Initial Success'));

  runApp(const MyApp());
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
      initialRoute: MyConstant.rountAuthen,
    );
  }
}
