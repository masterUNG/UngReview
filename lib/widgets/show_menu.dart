// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/widgets/show_text.dart';

class ShowMenu extends StatelessWidget {
  final String label;
  final String detail;
  final IconData iconData;
  final Function() tapFunc;
  const ShowMenu({
    Key? key,
    required this.label,
    required this.detail,
    required this.iconData,
    required this.tapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(onTap: tapFunc,
      leading: Icon(
        iconData,
        color: MyConstant.dark,
      ),
      title: ShowText(
        label: label,
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowText(label: detail),
    );
  }
}
