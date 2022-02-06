import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungreview/models/product_model.dart';
import 'package:ungreview/utility/my_constant.dart';
import 'package:ungreview/utility/my_dialog.dart';
import 'package:ungreview/widgets/show_button.dart';
import 'package:ungreview/widgets/show_form.dart';
import 'package:ungreview/widgets/show_image.dart';
import 'package:ungreview/widgets/show_text.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? file;
  String? nameProduct, detailProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Add Product'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newImage(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newName(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newDetail(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonAddProduct(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ShowButton buttonAddProduct() => ShowButton(
      label: 'Add Product',
      pressFunc: () {
        if (file == null) {
          MyDialog(context: context)
              .normalDialog('No Image ?', 'Please Take Photo');
        } else if ((nameProduct?.isEmpty ?? true) ||
            (detailProduct?.isEmpty ?? true)) {
          MyDialog(context: context)
              .normalDialog('Have Space ?', 'Please Fill Every Blank');
        } else {
          processUploadAndInsertProduct();
        }
      });

  ShowForm newDetail() => ShowForm(
        label: 'Detail Product :',
        iconData: Icons.details,
        changeFunc: (String string) => detailProduct = string.trim(),
      );

  ShowForm newName() => ShowForm(
        label: 'Name Product :',
        iconData: Icons.add_box_outlined,
        changeFunc: (String string) => nameProduct = string.trim(),
      );

  Stack newImage() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: 250,
            height: 250,
            child: file == null
                ? const ShowImage(
                    path: 'images/image4.png',
                  )
                : Image.file(
                    file!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: ListTile(
                    leading: const ShowImage(
                      path: 'images/image4.png',
                    ),
                    title: ShowText(
                      label: 'Source Image ?',
                      textStyle: MyConstant().h2Style(),
                    ),
                    subtitle: const ShowText(label: 'Please Choose Image'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        procressTakePhoto(ImageSource.camera);
                      },
                      child: ShowText(
                        label: 'Camera',
                        textStyle: MyConstant().h3PinkStyle(),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        procressTakePhoto(ImageSource.gallery);
                      },
                      child: ShowText(
                        label: 'Gallery',
                        textStyle: MyConstant().h3PinkStyle(),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: ShowText(
                        label: 'Cancel',
                        textStyle: MyConstant().h3PinkStyle(),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.add_a_photo,
              color: MyConstant.primary,
              size: 48,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> procressTakePhoto(ImageSource source) async {
    var result = await ImagePicker().pickImage(
      source: source,
      maxWidth: 800,
      maxHeight: 800,
    );
    setState(() {
      file = File(result!.path);
    });
  }

  Future<void> processUploadAndInsertProduct() async {
    String nameImage = 'image${Random().nextInt(1000000)}.jpg';

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('product/$nameImage');
    UploadTask uploadTask = reference.putFile(file!);
    await uploadTask.whenComplete(() async {
      await reference.getDownloadURL().then((value) async {
        String urlImage = value;
        print('Upload Image Success $urlImage');

        await FirebaseAuth.instance.authStateChanges().listen((event) async {
          String uidSeller = event!.uid;
          print('uidSeller ==>> $uidSeller');

          DateTime dateTime = DateTime.now();
          print('datetime = $dateTime');

          ProductModel productModel = ProductModel(
              urlImage: urlImage,
              nameProduct: nameProduct!,
              detailProduct: detailProduct!,
              uidSeller: uidSeller,
              timestamp: Timestamp.fromDate(dateTime));

          await FirebaseFirestore.instance
              .collection('product')
              .doc()
              .set(productModel.toMap())
              .then((value) => Navigator.pop(context));
        });
      });
    });
  }
}
