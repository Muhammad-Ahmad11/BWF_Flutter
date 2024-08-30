import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productImage: element.get("productImage"),
      productName: element.get("productName"),
      productPrice: element.get("productPrice"),
      productId: element.get("productId"),
      productUnit: element.get("productUnit"),
    );
    search.add(productModel!);
  }

  /////////////// ClassicComforts ///////////////////////////////
  List<ProductModel> classicComfortsList = [];

  fetchClassicComfortsData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("ClassicComforts").get();

    for (var element in value.docs) {
      productModels(element);

      newList.add(productModel!);
    }
    classicComfortsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getClassicComfortsDataList {
    return classicComfortsList;
  }

//////////////// Crispy Cravings ///////////////////////////////////////

  List<ProductModel> crispyCravingsList = [];

  fetchCrispyCravingsData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("CrispyCravings").get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    crispyCravingsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getCrispyCravingsDataList {
    return crispyCravingsList;
  }

//////////////// Fresh Bites ///////////////////////////////////////

  List<ProductModel> freshBitesList = [];

  fetchFreshBitesData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("FreshBites").get();

    for (var element in value.docs) {
      productModels(element);
      newList.add(productModel!);
    }
    freshBitesList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFreshBitesDataList {
    return freshBitesList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get getAllProductSearch {
    return search;
  }
}
