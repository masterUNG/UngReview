import 'package:flutter/material.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/widgets/show_signout.dart';
import 'package:ungreview/widgets/show_text.dart';

class MyServiceBuyer extends StatefulWidget {
  const MyServiceBuyer({Key? key}) : super(key: key);

  @override
  _MyServiceBuyerState createState() => _MyServiceBuyerState();
}

class _MyServiceBuyerState extends State<MyServiceBuyer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyer'),
      ),
      drawer: Drawer(
        child: ShowSignOut(),
      ),
    );
  }
}
