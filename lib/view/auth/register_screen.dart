import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/auth/auth_state.dart';
import 'package:map_pro/bloc/country/country_bloc.dart';
import 'package:map_pro/bloc/country/country_state.dart';
import 'package:map_pro/controller/auth_controller.dart';
import 'package:map_pro/controller/country_controller.dart';
import 'package:map_pro/core/theme/text_styles.dart';
import 'package:map_pro/bloc/auth/auth_bloc.dart';
import 'package:map_pro/bloc/auth/passwordVisibilityCubit.dart';
import 'package:map_pro/model/country_model.dart';
import 'package:map_pro/view/widgets/button_widget.dart';
import 'package:map_pro/view/widgets/dropDownField_widget.dart';
import 'package:map_pro/view/widgets/passwordField_widget.dart';
import 'package:map_pro/view/widgets/textformfield_widget.dart';


class RegisterScreen extends StatefulWidget
{
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
{
  final formKey = GlobalKey<FormState>();
  TextEditingController?  usernameController;
  TextEditingController? emailController;
  TextEditingController? mobileController;
  TextEditingController? passwordController;
  TextEditingController? confirmPasswordController;
  AuthController? controller;
  CountryController? countryController;

  @override
  void initState()
  {
    super.initState();
    usernameController =   TextEditingController();
    emailController =   TextEditingController();
    mobileController =   TextEditingController();
    passwordController =   TextEditingController();
    confirmPasswordController =   TextEditingController();
     controller = AuthController(context,formKey);
     countryController = CountryController(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      CountryController(context).fetchCountryList();
    });
  }
  @override
  void dispose()
  {
    super.dispose();
    usernameController!.dispose();
    emailController!.dispose();
    mobileController!.dispose();
    passwordController!.dispose();
    confirmPasswordController!.dispose();
  }

  @override
  Widget build(BuildContext context)
  {

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.purple,
        body: SafeArea(
          child:MultiBlocListener(
            listeners:
            [
            BlocListener<AuthBloc, AuthState>(listener: (context, state)
            {
              controller!.handleState(state);
            }),
              BlocListener<CountryBloc, CountryState>(listener: (context, state)
            {
              countryController!.handleState(state);

            }),
          ],

            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormFieldWidget(
                              controller: usernameController!,
                              hintText: 'Username',
                              prefixIcon: const Icon(Icons.person),
                            ),
                            const SizedBox(height: 20),
                            TextFormFieldWidget(
                              controller: emailController!,
                              hintText: 'Email',
                              prefixIcon: const Icon(Icons.mail),
                            ),
                            const SizedBox(height: 20),
                            TextFormFieldWidget(
                              controller: mobileController!,
                              hintText: 'Mobile',
                              prefixIcon: const Icon(Icons.phone),
                            ),
                            const SizedBox(height: 20),
                          BlocBuilder<CountryBloc, CountryState>(
                            builder: (context, state) {
                              if (state is CountryLoaded) {

                                return ValueListenableBuilder<Country?>(
                                  valueListenable: countryController!.selectedCountry,
                                  builder: (context, selected, _) {
                                    return DropdownFieldWidget(
                                      value: selected,
                                      items: state.countries,
                                      hintText: 'Select Country',
                                      onChanged: countryController!.setSelectedCountry,
                                      validator: (value) =>
                                      value == null ? 'Please select a country' : null,
                                    );
                                  },
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                            const SizedBox(height: 20),
                             BlocSelector<PasswordVisibilityCubit, Map<String, bool>, bool>(
                                selector: (state) => state["New Password"] ?? true,
                                builder: (context, obscure) {
                                  return PasswordFieldWidget(
                                    controller: passwordController!,
                                    hintText: 'Password',
                                    obscurePassword: obscure,
                                    onChanged: ()
                                    {
                                      context.read<PasswordVisibilityCubit>().toggle('New Password');

                                    },
                                  );
                                }
                            ),
                            const SizedBox(height: 20),
                            BlocSelector<PasswordVisibilityCubit, Map<String, bool>, bool>(
                                selector: (state) => state["Confirm Password"] ?? true,
                                builder: (context, obscure) {
                                  return PasswordFieldWidget(
                                    controller: confirmPasswordController!,
                                    hintText: 'Confirm Password',
                                    obscurePassword: obscure,
                                    onChanged: ()
                                    {
                                      context.read<PasswordVisibilityCubit>().toggle('Confirm Password');

                                    },
                                  );
                                }
                            ),

                            const SizedBox(height: 24),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return const CircularProgressIndicator();
                                }
                                return ButtonWidget(
                                  buttonText: "Register",
                                  onSubmit: ()
                                  {
                                    controller!.register(
                                      name: usernameController!.text,
                                      email: emailController!.text,
                                      phone: mobileController!.text,
                                      password: passwordController!.text,
                                      countryData: countryController!.selectedCountry.value!,
                                    );

                                  },
                                );
                              },
                            ),

                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyles.smallHintText,
                                ),
                                TextButton(
                                  onPressed: ()
                                  {
                                    Navigator.pushNamed(context, '/');

                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyles.smallHintButtonText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
