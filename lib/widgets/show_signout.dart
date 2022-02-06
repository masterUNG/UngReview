import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/widgets/show_text.dart';

class ShowSignOut extends StatelessWidget {
  const ShowSignOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await FirebaseAuth.instance.signOut().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, MyConstant.rountAuthen, (route) => false));
          },
          tileColor: Colors.red.shade300,
          leading: Icon(
            Icons.exit_to_app,
            color: MyConstant.dark,
            size: 36,
          ),
          title: ShowText(
            label: 'Sign Out',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: const ShowText(label: 'Sign Out and Move To Authen'),
        ),
      ],
    );
  }
}
