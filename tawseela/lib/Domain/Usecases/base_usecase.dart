import 'package:dartz/dartz.dart';
import '../../Data/Network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure,Out>> execute(In input);
}

abstract class NonFutureBaseUseCase<In, Out> {
  Either<Failure,Out> execute(In input);

}