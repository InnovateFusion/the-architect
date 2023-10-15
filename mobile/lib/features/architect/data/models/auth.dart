import 'package:architect/features/architect/domains/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required String accessToken,
    required String tokenType,
  }) : super(
          accessToken: accessToken,
          tokenType: tokenType,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'tokenType': tokenType,
    };
  }
}
