import 'package:flutter/material.dart';
import 'package:practical_demo/Config/string.dart';
import 'package:practical_demo/Screen/Product/Product%20component/productcard.dart';
import 'package:provider/provider.dart';
import '../../provider/product_provider.dart';
import 'Product component/categories.dart';
import 'Product component/filterpopup.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppStrings.productlist),
        actions: [
          IconButton(
            icon: Row(
              children: [
                Text(AppStrings.filter),
                SizedBox(width: 2),
                Icon(Icons.filter_list),
              ],
            ),
            onPressed: () => showFilterPopup(context),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return provider.isloading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    CategoriesRow(),
                    Expanded(child: ProductList()),
                  ],
                );
        },
      ),
    );
  }

  void showFilterPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return FilterPopup();
      },
    );
  }
}
