part of 'dolar_bloc.dart';

abstract class RatesState extends Equatable {
  const RatesState();

  @override
  List<Object> get props => [];
}

class RatesInitial extends RatesState {}

class RatesLoading extends RatesState {}

class RatesLoaded extends RatesState {
  const RatesLoaded(this.dollars);
  final List<Dollar> dollars;

  @override
  List<Object> get props => [dollars];
}

class RatesError extends RatesState {
  const RatesError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
