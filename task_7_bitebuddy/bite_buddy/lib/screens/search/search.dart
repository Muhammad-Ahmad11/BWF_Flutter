import 'package:flutter/material.dart';
import 'package:food_app/models/product_model.dart';
import 'package:food_app/theme/colors.dart';
import 'package:food_app/widgets/single_item.dart';

class Search extends StatefulWidget {
  final List<ProductModel>? search;

  const Search({super.key, this.search});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem(String query) {
    List<ProductModel> searchFood = widget.search!.where((element) {
      return element.productName!.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Search',
          style: TextStyle(
              color: textColor, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Items"),
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color(0xffc2c2c2),
                filled: true,
                hintText: "Search items in the store",
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: _searchItem.map((data) {
              return SingleItem(
                isBool: false,
                productImage: data.productImage!,
                productName: data.productName!,
                productPrice: data.productPrice!,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
