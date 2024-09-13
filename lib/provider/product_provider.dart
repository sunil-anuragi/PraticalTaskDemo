import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practical_demo/Config/string.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  List<Brand> _brands = [];
  List<Product> get products => _products;
  List<Category> get categories => _categories;
  List<Brand> get brands => _brands;
  List<Category> _selectedCategories = [];
  List<Brand> _selectedBrands = [];
  List<Category> get selectedCategories => _selectedCategories;
  List<Brand> get selectedBrands => _selectedBrands;
  bool isloading = false;
  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isloading = true;
    final response =
        await http.get(Uri.parse(Apisurl.productlist));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final productsData = data['products'] as List;
      _products = productsData.map((productJson) {
        return Product.fromJson(productJson);
      }).toList();

      List<Category> uniqueCategories = [];
      for (var product in _products) {
        bool categoryExists = false;
        for (var category in uniqueCategories) {
          if (category.name == product.category) {
            categoryExists = true;
            break;
          }
        }
        if (!categoryExists) {
          uniqueCategories.add(Category(name: product.category));
        }
      }
      _categories = uniqueCategories;

      List<Brand> uniqueBrands = [];
      for (var product in _products) {
        bool brandExists = false;
        for (var brand in uniqueBrands) {
          if (brand.name == product.brand) {
            brandExists = true;
            break;
          }
        }
        if (!brandExists) {
          uniqueBrands.add(Brand(name: product.brand));
        }
      }
      _brands = uniqueBrands;
      isloading = false;
      notifyListeners();
    } else {
      isloading = false;
      throw Exception('Failed to load products');
    }
  }

  void toggleCategorySelection(Category category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  void toggleBrandSelection(Brand brand) {
    if (_selectedBrands.contains(brand)) {
      _selectedBrands.remove(brand);
    } else {
      _selectedBrands.add(brand);
    }
    notifyListeners();
  }

  List<Product> getFilteredProducts() {
    return _products.where((product) {
      final categoryMatch = _selectedCategories.isEmpty ||
          _selectedCategories
              .any((category) => category.name == product.category);
      final brandMatch = _selectedBrands.isEmpty ||
          _selectedBrands.any((brand) => brand.name == product.brand);
      return categoryMatch && brandMatch;
    }).toList();
  }
}
