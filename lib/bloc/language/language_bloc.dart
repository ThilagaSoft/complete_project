
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/language/language_state.dart';

import 'language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<ChangeLanguageEvent>((event, emit) async {
      await event.context.setLocale(event.locale); // Apply locale globally
      emit(LanguageChanged(locale: event.locale));
    });
  }
}