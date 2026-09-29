import 'dart:convert';
import 'package:gtrbd_task/models/customer_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://www.hisabplus.com/Values/';

  static const String imageBaseUrl =
      'https://www.hisabplus.com/';

  Future<Map<String, dynamic>> login(
      String username,
      String password,
      int companyId,
      ) async {
   // companyId=1;
    final uri = Uri.parse(
        '${baseUrl}LogIn'
    ).replace(
      queryParameters: {
        'UserName': username,
        'Password': password,
        'ComId': companyId.toString(),
      },
    );

    final response = await http.get(uri);
    //debugPrint('Response: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Login failed');
  }

  Future<CustomerResponse> getCustomers(
      String token,
      int pageNo,
      int pageSize,
      ) async {
    final uri = Uri.parse('${baseUrl}GetCustomerList').replace(
      queryParameters: {
        'searchquery': '',
        'pageNo': pageNo.toString(),
        'pageSize': pageSize.toString(),
        'SortyBy': 'Balance',
      },
    );

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final customerResponse = CustomerResponse.fromJson(data);
      if (customerResponse.error) {
        throw Exception('Could not load customers. Please try again.');
      }
      return customerResponse;
    }

    throw Exception('Could not load customers. Please try again.');
  }
}
