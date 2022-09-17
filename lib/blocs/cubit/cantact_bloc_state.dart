part of 'cantact_bloc_cubit.dart';

@immutable
abstract class CantactBlocState {}

class CantactBlocInitial extends CantactBlocState {}

class CantactBlocLoaded extends CantactBlocState {}

class CantactBlocLoading extends CantactBlocState {}

class CantactBlocLoadedError extends CantactBlocState {}

class CantactBlocedited extends CantactBlocState {}

class CantactBloceRemoved extends CantactBlocState {}

class CantactBlocServerError extends CantactBlocState {
  final String errorMessage;

  CantactBlocServerError(this.errorMessage);
}
