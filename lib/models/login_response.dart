class LoginResponse{
  final String token;
  final String userName;
  final int userId;
  final int comId;
  final String Email;
  final String companyName;
  final String roleName;
  final String? imagePath;

  LoginResponse({
    required this.token,
    required this.userName,
    required this.userId,
    required this.comId,
    required this.Email,
    required this.companyName,
    required this.roleName,
    this.imagePath});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['Token'],
      userName: json['UserName'],
      userId: json['UserId'],
      comId: json['ComId'],
      Email: json['Email'],
      companyName: json['CompanyName'],
      roleName: json['RoleName'],
      imagePath: json['EmpImagePath'],
    );
  }
}