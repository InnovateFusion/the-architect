import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  const Auth({
    required this.accessToken,
    required this.tokenType,
  });

  final String accessToken;
  final String tokenType;

  @override
  List<Object?> get props => [
        accessToken,
        tokenType,
      ];
}
