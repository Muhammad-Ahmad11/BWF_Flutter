import 'package:flutter/material.dart';
import 'package:food_app/theme/colors.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/viewmodels/providers/wishlist_provider.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListProvider? wishListProvider;
  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        wishListProvider!.deleteWishtList(delete.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("WishList Product"),
      content: const Text("Remove this product from WishList?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider!.getWishtListData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WishList",
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: wishListProvider!.getWishList.length,
        itemBuilder: (context, index) {
          ProductModel data = wishListProvider!.getWishList[index];
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SingleItem(
                isBool: true,
                productImage: data.productImage!,
                productName: data.productName!,
                productPrice: data.productPrice!,
                productId: data.productId!,
                productQuantity: data.productQuantity!,
                onDelete: () {
                  showAlertDialog(context, data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
