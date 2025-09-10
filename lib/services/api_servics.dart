import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../models/single_product_model.dart';
import '../models/user_model.dart';

class ApiServics {
  static Future<UserModel?> userCreateAccount(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse("https://mock-api.calleyacd.com/api/auth/register"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      var jsonData = jsonDecode(response.body);
      return UserModel.fromJsonToModel(jsonData);
    }
    return null;
  }

  static Future<SingleProductModel?> singleProduct() async {
    var url = await http.get(Uri.parse("https://dummyjson.com/products/1"));
    if (url.statusCode == 200) {
      var jsonData = jsonDecode(url.body);
      return SingleProductModel.fromJson(jsonData);
    }
    return null;
  }

  static Future<UserModel?> userLogIn(Map<String, dynamic> data) async {
    var response = await http.post(
      Uri.parse("https://mock-api.calleyacd.com/api/auth/login"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return UserModel.fromJsonToModel(jsonData);
    }
    return null;
  }

  static Future<ProductModel?> getProductApiData() async {
    var url = await http.get(Uri.parse("https://dummyjson.com/products"));
    if (url.statusCode == 200) {
      var jsonData = jsonDecode(url.body);
      return ProductModel.fromJsonToModel(jsonData);
    }
    return null;
  }




  static Future<List<String>?> getCategoriesData() async {
    try {
      final response = await http.get(
        Uri.parse("https://dummyjson.com/products/categories"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data as List)
            .map((e) => e['name'].toString())
            .toList();
      } else {
        return null;
      }
    } catch (e) {
      print("Category API Error: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getProductsByCategory(
      String category) async {
    try {
      final response = await http
          .get(Uri.parse("https://dummyjson.com/products/category/$category"));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Products by Category API Error: $e");
      return null;
    }
  }
}
