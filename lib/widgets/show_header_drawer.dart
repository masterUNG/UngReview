import 'package:flutter/material.dart';
import 'package:ungreview/utility/my_constant.dart';

class ShowHeaderDrawer extends StatelessWidget {
  const ShowHeaderDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: MyConstant().mainBox(),
      accountName: null,
      accountEmail: null,
    );
  }
}
