part of 'dolar_bloc.dart';

abstract class RatesEvent extends Equatable {
  const RatesEvent();

  @override
  List<Object> get props => [];
}

class FetchRatesEvent extends RatesEvent {}

// class GetRatesEvent extends RatesEvent {}

class RefreshRatesEvent extends RatesEvent {}
