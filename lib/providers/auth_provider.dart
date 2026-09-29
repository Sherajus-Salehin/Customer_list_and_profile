import 'package:flutter/material.dart';
import 'package:gtrbd_task/models/login_response.dart';
import 'package:gtrbd_task/services/api_services.dart';
class AuthProvider extends ChangeNotifier{
  final ApiService _apiService=ApiService();

  bool isLoading=false;
  String? errorMessage;
  LoginResponse? user;

  bool get isLoggedIn => user!=null;

  Future<bool> login(
      String username,
      String password,
      int companyId,
      )
  async{
    isLoading=true;
    errorMessage=null;
    notifyListeners();
    try{
      final response= await _apiService.login(
          username,
          password,
          companyId);
      user= LoginResponse.fromJson(response);
      isLoading=false;
      notifyListeners();

      return true;
    }catch(e){
      isLoading=false;
      errorMessage='failed to login';
      notifyListeners();

      return false;
    }
  }
}