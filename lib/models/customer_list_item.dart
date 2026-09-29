import 'customer.dart';

class CustomerListItem {
  final int id;
  final String name;
  final String? phone;
  final String? email;
  final String? imagePath;
  final double? totalDue;

  CustomerListItem({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.imagePath,
    this.totalDue,
  });

  factory CustomerListItem.fromCustomer(Customer customer) {
    return CustomerListItem(
      id: customer.id,
      name: customer.name,
      phone: customer.phone,
      email: customer.email,
      imagePath: customer.imagePath,
      totalDue: customer.totalDue,
    );
  }
}