import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/country/country_event.dart';
import 'package:map_pro/bloc/country/country_state.dart';
import 'package:map_pro/repository/country_repository.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {

  CountryBloc() : super(CountryInitial())
  {
    on<FetchCountries>(onFetchCountries);
  }

  Future<void> onFetchCountries(FetchCountries event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    try {
     final countriesList =  await CountryRepository().getAllCountries();

      emit(CountryLoaded(countriesList));
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }
}
