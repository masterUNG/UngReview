// ignore_for_file: invalid_return_type_for_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungreview/models/user_model.dart';
import 'package:ungreview/utility/get_data_by_uid.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/utility/my_dialog.dart';
import 'package:ungreview/widgets/show_button.dart';
import 'package:ungreview/widgets/show_form.dart';
import 'package:ungreview/widgets/show_image.dart';
import 'package:ungreview/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MyConstant().mainBox(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newImage(),
                newAppName(),
                newEmail(),
                newPassword(),
                newLogin(),
                newCreateAccount(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row newCreateAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ShowText(label: 'Non Account ? '),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.rountCreateAccount),
          child: ShowText(
            label: 'Create Account',
            textStyle: MyConstant().h3PinkStyle(),
          ),
        ),
      ],
    );
  }

  ShowButton newLogin() {
    return ShowButton(
      label: 'Login',
      pressFunc: () {
        if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
          MyDialog(context: context)
              .normalDialog('Have Space ?', 'Please Fill Every Blank');
        } else {
          processCheckAuthen();
        }
      },
    );
  }

  ShowForm newEmail() {
    return ShowForm(
      textInputType: TextInputType.emailAddress,
      label: 'Email :',
      iconData: Icons.email_outlined,
      changeFunc: (String string) => email = string.trim(),
    );
  }

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :',
      iconData: Icons.lock_outline,
      obcu: true,
      changeFunc: (String string) => password = string.trim(),
    );
  }

  Container newAppName() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: ShowText(
        label: MyConstant.appName,
        textStyle: MyConstant().h1Style(),
      ),
    );
  }

  SizedBox newImage() {
    return const SizedBox(
      width: 250,
      child: ShowImage(),
    );
  }

  Future<void> processCheckAuthen() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) async {
      String uid = value.user!.uid;
      print('uid ===> $uid');

      UserModel? userModel = await GetDataByUid(uid: uid).getUserModel();
      switch (userModel!.typeuser) {
        case 'buyer':
          Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.rountBuyer, (route) => false);
          break;
        case 'seller':
          Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.rountSeller, (route) => false);
          break;
        default:
      }
    }).catchError(
      (onError) => MyDialog(context: context).normalDialog(
        onError.code,
        onError.message,
      ),
    );
  }
}
