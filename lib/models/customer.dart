class Customer {
  final int id;
  final String name;
  final String? email;
  final String? primaryAddress;
  final String? secondaryAddress;
  final String? notes;
  final String? phone;
  final String? custType;
  final String? parentCustomer;
  final String? imagePath;
  final bool isInActive;

  final double? totalDue;
  final String? lastSalesDate;
  final String? lastInvoiceNo;
  final String? lastSoldProduct;
  final double? totalSalesValue;
  final double? totalSalesReturnValue;
  final double? totalAmountBack;
  final double? totalCollection;
  final String? lastTransactionDate;
  final String? clientCompanyName;

  Customer({
    required this.id,
    required this.name,
    this.email,
    this.primaryAddress,
    this.secondaryAddress,
    this.notes,
    this.phone,
    this.custType,
    this.parentCustomer,
    this.imagePath,
    required this.isInActive,
    this.totalDue,
    this.lastSalesDate,
    this.lastInvoiceNo,
    this.lastSoldProduct,
    this.totalSalesValue,
    this.totalSalesReturnValue,
    this.totalAmountBack,
    this.totalCollection,
    this.lastTransactionDate,
    this.clientCompanyName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['Id'],
      name: json['Name'] ?? '',
      email: json['Email'],
      primaryAddress: json['PrimaryAddress'],
      secondaryAddress: json['SecoundaryAddress'],
      notes: json['Notes'],
      phone: json['Phone'],
      custType: json['CustType'],
      parentCustomer: json['ParentCustomer'],
      imagePath: json['ImagePath'],
      isInActive: json['IsInActive'] ?? false,
      totalDue: (json['TotalDue'] as num?)?.toDouble(),
      lastSalesDate: json['LastSalesDate'],
      lastInvoiceNo: json['LastInvoiceNo'],
      lastSoldProduct: json['LastSoldProduct'],
      totalSalesValue: (json['TotalSalesValue'] as num?)?.toDouble(),
      totalSalesReturnValue:
      (json['TotalSalesReturnValue'] as num?)?.toDouble(),
      totalAmountBack: (json['TotalAmountBack'] as num?)?.toDouble(),
      totalCollection: (json['TotalCollection'] as num?)?.toDouble(),
      lastTransactionDate: json['LastTransactionDate'],
      clientCompanyName: json['ClinetCompanyName'],
    );
  }
}