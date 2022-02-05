import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/utility/my_dialog.dart';
import 'package:ungreview/widgets/show_button.dart';
import 'package:ungreview/widgets/show_form.dart';
import 'package:ungreview/widgets/show_text.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser, name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            children: [
              newTitle('Information :'),
              newName(),
              newTitle('Type User :'),
              radioTypeUser(),
              newEmail(),
              newPassword(),
              newCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  ShowButton newCreateAccount() => ShowButton(
        label: 'Create Account',
        pressFunc: () {
          if ((name?.isEmpty ?? true) ||
              (email?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            MyDialog(context: context)
                .normalDialog('Have Space ?', 'Please Fill Every Blank');
          } else if (typeUser?.isEmpty ?? true) {
            MyDialog(context: context)
                .normalDialog('No Type User', 'Please Choose Type User');
          } else {
            processCreateAccount();
          }
        },
      );

  Row radioTypeUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        newBuyer(),
        newSeller(),
      ],
    );
  }

  Container newBuyer() {
    return Container(
      width: 150,
      child: RadioListTile(
        title: const ShowText(label: 'Buyer'),
        value: 'buyer',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value as String?;
          });
        },
      ),
    );
  }

  Container newSeller() {
    return Container(
      width: 150,
      child: RadioListTile(
        title: const ShowText(label: 'Seller'),
        value: 'seller',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value as String?;
          });
        },
      ),
    );
  }

  Container newTitle(String string) {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8),
      width: 250,
      child: ShowText(
        label: string,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  ShowForm newPassword() => ShowForm(
        label: 'Password :',
        iconData: Icons.lock_outline,
        changeFunc: (String string) => password = string.trim(),
      );

  ShowForm newEmail() => ShowForm(
        label: 'Email :',
        iconData: Icons.email_outlined,
        changeFunc: (String string) => email = string.trim(),
      );

  ShowForm newName() => ShowForm(
        label: 'Name :',
        iconData: Icons.fingerprint,
        changeFunc: (String string) => name = string.trim(),
      );

  Future<void> processCreateAccount() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print('Create Account Success');
    })
        // ignore: invalid_return_type_for_catch_error
        .catchError((onError) => MyDialog(context: context)
            .normalDialog(onError.code, onError.message));
  }
}
