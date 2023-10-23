import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/usecase.dart';
import '../../entities/chat.dart';
import '../../repositories/chat.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ViewsChat extends UseCase<List<Chat>, Params> {
  ViewsChat(
    this.repository,
  );

  final ChatRepository repository;

  @override
  Future<Either<Failure, List<Chat>>> call(Params params) async {
    return await repository.views(params.id);
  }
}

class Params extends Equatable {
  const Params({
    required this.id,
  });

  final String id;

  @override
  List<Object?> get props => [
        id,
      ];
}
