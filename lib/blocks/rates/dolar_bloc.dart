import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/dollar_model.dart';
// import '../../repository/dolarsi_repository.dart';
import '../../repository/dolarhoy_repository.dart';

part 'dolar_event.dart';
part 'dolar_state.dart';

class RatesBloc extends Bloc<RatesEvent, RatesState> {
  RatesBloc(this.ratesRepository) : super(RatesInitial()) {
    on<FetchRatesEvent>(
        (FetchRatesEvent event, Emitter<RatesState> emit) async {
      emit(RatesLoading());
      try {
        // final List<Dollar> dolar = await ratesRepository.fetchDolarsi();
        final List<Dollar> dolar = await ratesRepository.fetchDolarhoy();
        emit(RatesLoaded(dolar));
      } catch (error) {
        emit(RatesError(error.toString()));
      }
    });

    // on<GetRatesEvent>((event, emit) async {
    //   // emit(RatesLoading());
    //   try {
    //     final rates = await ratesRepository.getRates();
    //     emit(RatesLoaded(rates));
    //   } catch (error) {
    //     emit(RatesError(error.toString()));
    //   }
    // });
    on<RefreshRatesEvent>(
        (RefreshRatesEvent event, Emitter<RatesState> emit) async {
      try {
        final List<Dollar> dolar = await ratesRepository.fetchDolarhoy();
        emit(RatesLoaded(dolar));
      } catch (error) {
        emit(RatesError(error.toString()));
      }
    });
  }
  final DolarhoyRepository ratesRepository;
}
