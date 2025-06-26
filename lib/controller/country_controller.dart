import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/country/country_bloc.dart';
import 'package:map_pro/bloc/country/country_event.dart';
import 'package:map_pro/bloc/country/country_state.dart';
import 'package:map_pro/model/country_model.dart';
import 'package:map_pro/view/widgets/common_loading.dart';

class CountryController {
  final BuildContext context;
  CountryController(this.context);

  final ValueNotifier<List<Country>> countriesList = ValueNotifier<List<Country>>([]);
  final ValueNotifier<Country?> selectedCountry = ValueNotifier<Country?>(null);

  void fetchCountryList() {
    context.read<CountryBloc>().add(FetchCountries());
  }

  void setSelectedCountry(Country? country) {
    selectedCountry.value = country;
  }

  void handleState(CountryState state) {
    if (state is CountryLoaded) {
      final sortedList = [...state.countries] // clone the list
        ..sort((a, b) => a.name.common.compareTo(b.name.common));

      countriesList.value = sortedList; // ✅ sorted and assigned

      LoadingDialog.hide(context);
    } else if (state is CountryLoading) {
      LoadingDialog.show(context, "Countries");
    } else if (state is CountryError) {
      LoadingDialog.hide(context);
      print(state.message);
    }
  }
}
