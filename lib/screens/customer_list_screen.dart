import 'package:flutter/material.dart';
import 'package:gtrbd_task/models/customer.dart';
import 'package:gtrbd_task/providers/auth_provider.dart';
import 'package:gtrbd_task/providers/customer_provider.dart';
import 'package:gtrbd_task/screens/customer_details_screen.dart';
import 'package:gtrbd_task/services/api_services.dart';
import 'package:provider/provider.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadPage(1));
  }

  void _loadPage(int pageNo) {
    final token = context.read<AuthProvider>().user?.token;
    if (token != null && token.isNotEmpty) {
      context.read<CustomerProvider>().loadCustomers(token, pageNo: pageNo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: Consumer<CustomerProvider>(
        builder: (context, customerProvider, child) {
          if (customerProvider.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(customerProvider.errorMessage!, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _loadPage(customerProvider.currentPage),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (customerProvider.customers.isEmpty) {
            return const Center(child: Text('No customers found.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: customerProvider.customers.length,
                  itemBuilder: (context, index) => _customerTile(
                    context,
                    customerProvider.customers[index],
                  ),
                ),
              ),
              _pagination(customerProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _customerTile(BuildContext context, Customer customer) {
    final imagePath = customer.imagePath;
    final hasImage = imagePath != null && imagePath.isNotEmpty;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: hasImage
              ? NetworkImage('${ApiService.imageBaseUrl}$imagePath')
              : null,
          child: hasImage ? null : const Icon(Icons.person),
        ),
        title: Text(customer.name),
        subtitle: Text(customer.phone ?? customer.email ?? 'No contact information'),
        trailing: customer.totalDue == null
            ? null
            : Text('Due: ${customer.totalDue!.toStringAsFixed(2)}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerDetailsScreen(customer: customer),
            ),
          );
        },
      ),
    );
  }

  Widget _pagination(CustomerProvider customerProvider) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: customerProvider.currentPage > 1
                ? () => _loadPage(customerProvider.currentPage - 1)
                : null,
            child: const Text('Previous'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Page ${customerProvider.currentPage} of ${customerProvider.pageCount}'),
          ),
          ElevatedButton(
            onPressed: customerProvider.pageCount > 0 &&
                    customerProvider.currentPage < customerProvider.pageCount
                ? () => _loadPage(customerProvider.currentPage + 1)
                : null,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
