import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ungreview/models/product_model.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/widgets/show_button.dart';
import 'package:ungreview/widgets/show_progress.dart';
import 'package:ungreview/widgets/show_text.dart';

class ListProductSeller extends StatefulWidget {
  const ListProductSeller({Key? key}) : super(key: key);

  @override
  _ListProductSellerState createState() => _ListProductSellerState();
}

class _ListProductSellerState extends State<ListProductSeller> {
  bool load = true;
  bool? haveData;
  var produceModels = <ProductModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readProduct();
  }

  Future<void> readProduct() async {
    produceModels.clear();

    await FirebaseFirestore.instance
        .collection('product')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        for (var item in value.docs) {
          ProductModel productModel = ProductModel.fromMap(item.data());
          setState(() {
            load = false;
            haveData = true;
            produceModels.add(productModel);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ShowButton(
        label: 'Add New Product',
        pressFunc: () =>
            Navigator.pushNamed(context, MyConstant.rountAddProduct)
                .then((value) => readProduct()),
      ),
      body: load
          ? const ShowProgress()
          : haveData!
              ? ListView.builder(
                  itemCount: produceModels.length,
                  itemBuilder: (context, index) =>
                      LayoutBuilder(builder: (context, constrain) {
                    return Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 150,
                              height: 120,
                              child: Image.network(
                                produceModels[index].urlImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: constrain.maxWidth - 180,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowText(
                                  label: produceModels[index].nameProduct,
                                  textStyle: MyConstant().h2Style(),
                                ),
                                ShowText(
                                    label: produceModels[index].detailProduct)
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                )
              : Center(
                  child: ShowText(
                    label: 'No Product',
                    textStyle: MyConstant().h1Style(),
                  ),
                ),
    );
  }
}
