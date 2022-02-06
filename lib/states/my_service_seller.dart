import 'package:flutter/material.dart';
import 'package:ungreview/bodys/informaion_seller.dart';
import 'package:ungreview/bodys/list_product_seller.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/widgets/show_header_drawer.dart';
import 'package:ungreview/widgets/show_menu.dart';
import 'package:ungreview/widgets/show_signout.dart';

class MyServiceSeller extends StatefulWidget {
  const MyServiceSeller({Key? key}) : super(key: key);

  @override
  _MyServiceSellerState createState() => _MyServiceSellerState();
}

class _MyServiceSellerState extends State<MyServiceSeller> {
  var widgets = <Widget>[];
  int indexWiget = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widgets.add(const ListProductSeller());
    widgets.add(const InformationSeller());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller'),
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                ShowHeaderDrawer(),
                menuListProduct(context),
                menuInformationSeller(context),
              ],
            ),
            const ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWiget],
    );
  }

  ShowMenu menuListProduct(BuildContext context) {
    return ShowMenu(
      label: 'List Product',
      detail: 'List Product and Add Product',
      iconData: Icons.filter_1,
      tapFunc: () {
        setState(() {
          indexWiget = 0;
        });
        Navigator.pop(context);
      },
    );
  }

  ShowMenu menuInformationSeller(BuildContext context) {
    return ShowMenu(
      label: 'Information Seller',
      detail: 'Display, Add and Edit Information Seller',
      iconData: Icons.filter_2,
      tapFunc: () {
        setState(() {
          indexWiget = 1;
        });
        Navigator.pop(context);
      },
    );
  }
}
