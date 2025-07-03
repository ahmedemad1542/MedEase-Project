class LoginResponseModel {
  final String? accessToken;
  final String? role;
  final String? refreshToken;

  LoginResponseModel({
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'],
      role: json['Role'],
      refreshToken: json['refreshToken'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'Role': role,
      'refreshToken': refreshToken,
    };
  }
}
