import 'customer.dart';

class CustomerResponse {
  final int success;
  final bool error;
  final List<Customer> customerList;

  final int pageNo;
  final int pageSize;
  final int pageCount;
  final int totalRecordCount;

  CustomerResponse({
    required this.success,
    required this.error,
    required this.customerList,
    required this.pageNo,
    required this.pageSize,
    required this.pageCount,
    required this.totalRecordCount,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
      success: json['Success'] ?? 0,
      error: json['error'] ?? false,

      customerList: (json['CustomerList'] as List<dynamic>? ?? [])
          .map((customer) => Customer.fromJson(customer))
          .toList(),

      pageNo: json['PageNo'] ?? 1,
      pageSize: json['PageSize'] ?? 20,
      pageCount: json['PageCount'] ?? 0,
      totalRecordCount: json['TotalRecordCount'] ?? 0,
    );
  }
}