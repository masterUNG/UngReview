import 'package:flutter/material.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/widgets/show_button.dart';
import 'package:ungreview/widgets/show_form.dart';
import 'package:ungreview/widgets/show_image.dart';
import 'package:ungreview/widgets/show_text.dart';

class Authen extends StatelessWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

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
      pressFunc: () {},
    );
  }

  ShowForm newEmail() {
    return ShowForm(
      textInputType: TextInputType.emailAddress,
      label: 'Email :',
      iconData: Icons.email_outlined,
      changeFunc: (String string) {},
    );
  }

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :',
      iconData: Icons.lock_outline,
      obcu: true,
      changeFunc: (String string) {},
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
}
