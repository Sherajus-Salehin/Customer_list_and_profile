import 'package:flutter/material.dart';
import 'package:gtrbd_task/models/customer.dart';
import 'package:gtrbd_task/services/api_services.dart';

class CustomerProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Customer> customers = [];
  int currentPage = 1;
  int pageCount = 0;
  int totalRecordCount = 0;
  String? errorMessage;

  Future<void> loadCustomers(String token, {int pageNo = 1, int pageSize = 20}) async {
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getCustomers(token, pageNo, pageSize);
      customers = response.customerList;
      currentPage = response.pageNo;
      pageCount = response.pageCount;
      totalRecordCount = response.totalRecordCount;
    } catch (e) {
      errorMessage = 'Unable to load customers. Please check your connection and try again.';
    }

    notifyListeners();
  }
}
