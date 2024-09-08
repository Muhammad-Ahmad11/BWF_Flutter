import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/screens/check_out/delivery_details/delivery_details.dart';
import 'package:food_app/theme/colors.dart';
import 'package:food_app/viewmodels/providers/review_cart_provider.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatelessWidget {
  ReviewCartProvider? reviewCartProvider;

  ReviewCart({super.key});
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
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
        reviewCartProvider!.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Cart Product"),
      content: const Text("Do you want to delete this product fromt he cart?"),
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
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider!.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: const Text("Total Amount"),
        subtitle: Text(
          "\$ ${reviewCartProvider!.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () {
              if (reviewCartProvider!.getReviewCartDataList.isEmpty) {
                Fluttertoast.showToast(msg: "No Cart Data Found");
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DeliveryDetails(),
                ),
              );
            },
            child: const Text("Submit"),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Review Cart',
          style: TextStyle(
              color: textColor, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
      body: reviewCartProvider!.getReviewCartDataList.isEmpty
          ? const Center(
              child: Text("NO DATA"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider!.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider!.getReviewCartDataList[index];
                return Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SingleItem(
                      isBool: true,
                      wishList: false,
                      productImage: data.cartImage!,
                      productName: data.cartName!,
                      productPrice: data.cartPrice!,
                      productId: data.cartId!,
                      productQuantity: data.cartQuantity!,
                      productUnit: data.cartUnit,
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
