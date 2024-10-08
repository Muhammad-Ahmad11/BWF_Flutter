import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/theme/colors.dart';
import 'package:food_app/viewmodels/providers/review_cart_provider.dart';
import 'package:food_app/widgets/count.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  bool? isBool = false;
  String? productImage;
  String? productName;
  bool? wishList = false;
  int? productPrice;
  String? productId;
  int? productQuantity;
  Function()? onDelete;
  var productUnit;
  SingleItem(
      {super.key,
      this.productQuantity,
      this.productId,
      this.productUnit,
      this.onDelete,
      this.isBool,
      this.productImage,
      this.productName,
      this.productPrice,
      this.wishList});

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  ReviewCartProvider? reviewCartProvider;

  int? count;
  getCount() {
    setState(() {
      count = widget.productQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider!.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 90,
                  child: Center(
                    child: Image.network(
                      widget.productImage!,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName!,
                            style: const TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            "${widget.productPrice}\$",
                            style: const TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      widget.isBool == false
                          ? GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            title: const Text('Small'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: const Text('Medium'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            title: const Text('Large'),
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 15),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Small",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Text(widget.productUnit)
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  padding: widget.isBool == false
                      ? const EdgeInsets.symmetric(horizontal: 15, vertical: 32)
                      : const EdgeInsets.only(left: 15, right: 15),
                  child: widget.isBool == false
                      ? Count(
                          productId: widget.productId,
                          productImage: widget.productImage,
                          productName: widget.productName,
                          productPrice: widget.productPrice,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: widget.onDelete,
                                child: const Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              widget.wishList == false
                                  ? Container(
                                      height: 25,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (count == 1) {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "You reach minimum limit",
                                                  );
                                                } else {
                                                  setState(() {
                                                    count = count! - 1;
                                                  });
                                                  reviewCartProvider!
                                                      .updateReviewCartData(
                                                    cartImage:
                                                        widget.productImage,
                                                    cartId: widget.productId,
                                                    cartName:
                                                        widget.productName,
                                                    cartPrice:
                                                        widget.productPrice,
                                                    cartQuantity: count,
                                                  );
                                                }
                                              },
                                              child: const Icon(
                                                Icons.remove,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              "$count",
                                              style: const TextStyle(
                                                color: primaryColor,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (count! < 10) {
                                                  setState(() {
                                                    count = count! + 1;
                                                  });
                                                  reviewCartProvider!
                                                      .updateReviewCartData(
                                                    cartImage:
                                                        widget.productImage,
                                                    cartId: widget.productId,
                                                    cartName:
                                                        widget.productName,
                                                    cartPrice:
                                                        widget.productPrice,
                                                    cartQuantity: count,
                                                  );
                                                }
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : const Divider(
                height: 1,
                color: Colors.black45,
              )
      ],
    );
  }
}
