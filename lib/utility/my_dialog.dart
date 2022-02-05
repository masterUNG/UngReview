// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/widgets/show_image.dart';
import 'package:ungreview/widgets/show_text.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog(String title, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading:const ShowImage(),
          title: ShowText(label: title, textStyle: MyConstant().h2Style(),),
          subtitle: ShowText(label: message),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: ShowText(label: 'OK', textStyle: MyConstant().h3PinkStyle(),))],
      ),
    );
  }
}
