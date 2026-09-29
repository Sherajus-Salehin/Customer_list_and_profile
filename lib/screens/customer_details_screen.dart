import 'package:flutter/material.dart';
import 'package:gtrbd_task/models/customer.dart';
import 'package:gtrbd_task/services/api_services.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final hasImage = customer.imagePath != null && customer.imagePath!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text(customer.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundImage: hasImage
                  ? NetworkImage('${ApiService.imageBaseUrl}${customer.imagePath}')
                  : null,
              child: hasImage ? null : const Icon(Icons.person, size: 42),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              customer.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 20),
          _section('Customer Information', [
            _item('Phone', customer.phone),
            _item('Email', customer.email),
            _item('Primary address', customer.primaryAddress),
            _item('Secondary address', customer.secondaryAddress),
            _item('Customer type', customer.custType),
            _item('Parent customer', customer.parentCustomer),
            _item('Company', customer.clientCompanyName),
            _item('Notes', customer.notes),
          ]),
          _section('Account Information', [
            _item('Total due', _amount(customer.totalDue)),
            _item('Total sales', _amount(customer.totalSalesValue)),
            _item('Total collection', _amount(customer.totalCollection)),
            _item('Sales return', _amount(customer.totalSalesReturnValue)),
            _item('Amount back', _amount(customer.totalAmountBack)),
          ]),
          _section('Recent Activity', [
            _item('Last sales date', customer.lastSalesDate),
            _item('Last transaction date', customer.lastTransactionDate),
            _item('Last invoice no.', customer.lastInvoiceNo),
            _item('Last sold product', customer.lastSoldProduct),
          ]),
        ],
      ),
    );
  }

  String? _amount(double? value) => value == null ? null : value.toStringAsFixed(2);

  Widget _section(String title, List<Widget> items) {
    final visibleItems = items.whereType<ListTile>().toList();
    if (visibleItems.isEmpty) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), ...visibleItems],
        ),
      ),
    );
  }

  Widget _item(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return ListTile(dense: true, title: Text(label), subtitle: Text(value));
  }
}
