import 'package:flutter/material.dart';
import '../services/api_servics.dart';

class ApiCategoryProvider with ChangeNotifier {
  List<String> categoriesList = [];
  bool isLoading = false;

  Future<void> getCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      var response = await ApiServics.getCategoriesData();

      if (response != null) {
        categoriesList = List<String>.from(response);
      } else {
        categoriesList = [];
      }
    } catch (e) {
      categoriesList = [];
      debugPrint("Category fetch error: $e");
    }

    isLoading = false;
    notifyListeners();
  }



  String? selectedCategory;

  void selectCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void setCategories(List<String> categories) {
    categoriesList = categories;
    selectedCategory = categories.isNotEmpty ? categories[0] : null;
    notifyListeners();
  }

}
