import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shopsmart/models/single_product_model.dart';
import '../models/product_model.dart';
import '../services/api_servics.dart';

class ApiProductGetProvider with ChangeNotifier {
  bool isLoading = true;
  ApiProductGetProvider() {
    getProductApiData();
    getSingleProductData();
  }

  List<ProductDetailsModel>? productsList = [];
  SingleProductModel? singleProduct;


  Future<void> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse("https://dummyjson.com/products/search?q=$query"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        productsList = productsList = (data['products'] as List)
            .map((e) => ProductDetailsModel.fromJson(e))
            .toList();

        notifyListeners();
      } else {
        productsList = [];
        notifyListeners();
      }
    } catch (e) {
      print("Search Error: $e");
      productsList = [];
      notifyListeners();
    }
  }



  getProductApiData() async {
    var response = await ApiServics.getProductApiData();
    if (response != null) {
      productsList = response.products;
      notifyListeners();
    }
  }

  getSingleProductData() async {
    var response = await ApiServics.singleProduct();
    if (response != null) {
      singleProduct = response;
      notifyListeners();
    }
  }





  Future<void> getProductsByCategory(String category) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse("https://dummyjson.com/products/category/$category"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        productsList = (data['products'] as List<dynamic>)
            .map((e) => ProductDetailsModel.fromJson(e as Map<String, dynamic>))
            .toList();

      } else {
        productsList = [];
      }
    } catch (e) {
      productsList = [];
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }


}
