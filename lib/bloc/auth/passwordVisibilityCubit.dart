import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordVisibilityCubit extends Cubit<Map<String, bool>>
{
  PasswordVisibilityCubit() : super({});

  void toggle(String key)
  {

    final current = state[key] ?? true;
    emit({...state, key: !current});
  }

  bool isObscured(String key) => state[key] ?? true;
}
