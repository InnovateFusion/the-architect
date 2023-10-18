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
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }
}
