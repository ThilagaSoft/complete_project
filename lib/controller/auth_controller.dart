import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/auth/auth_event.dart';
import 'package:map_pro/bloc/auth/auth_state.dart';
import 'package:map_pro/model/country_model.dart';
import 'package:map_pro/view/widgets/successful_dialogbox.dart';

import '../bloc/auth/auth_bloc.dart';

class AuthController {
  final BuildContext context;
  final GlobalKey<FormState> formKey;
  AuthController(this.context, this.formKey);

  void register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required Country? countryData,
  }) {
    if(formKey.currentState!.validate())
      {
        context.read<AuthBloc>().add(RegisterEvent(
          userName: name,
          email: email,
          phone: phone,
          password: password,
          countryData: countryData!,
        ));
      }

  }

  void login({required String email,required String password})
  {
    if(formKey.currentState!.validate())
      {
        context.read<AuthBloc>().add(LoginEvent(email: email, password: password));

      }
  }

  void handleState(AuthState state)
  {
    if (state is RegisterSuccess)
    {
      showSuccessDialog(context, "Register Success", (){}).then((_)
      {
        Navigator.pushNamed(context, '/');
      });
    } else if (state is LoginSuccess)
    {
      showSuccessDialog(context, "Login Success", (){}).then((_) {
        Navigator.pushNamed(context, '/home');
      });
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message.replaceFirst("Exception: ", ""))),
      );
    }
  }
}
