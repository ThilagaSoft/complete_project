import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/chat/chat_bloc.dart';
import 'package:map_pro/bloc/location/map_bloc.dart';
import 'package:map_pro/view/language/language_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:map_pro/bloc/country/country_bloc.dart';
import 'package:map_pro/bloc/language/language_bloc.dart';
import 'package:map_pro/core/theme/app_color.dart';
import 'package:map_pro/core/theme/text_styles.dart';
import 'package:map_pro/bloc/auth/auth_bloc.dart';
import 'package:map_pro/repository/auth_repository.dart';
import 'package:map_pro/view/auth/login_screen.dart';
import 'package:map_pro/view/home/home_screen.dart';
import 'bloc/auth/passwordVisibilityCubit.dart';
import 'view/auth/register_screen.dart';
Future<void> _backgroundHandler(RemoteMessage message) async
{
  await Firebase.initializeApp();
  print('Background message: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', // put JSON files here
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (_) => PasswordVisibilityCubit()),
          BlocProvider(create: (_)=>AuthBloc(authRepository: AuthRepository())),
          BlocProvider(create: (_)=>LanguageBloc()),
          BlocProvider(create: (context) => CountryBloc()),
          BlocProvider( create: (_) => MapBloc()..startLocationUpdates(),),
          BlocProvider(create: (context) => ChatBloc()),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes:
          {
            '/home': (_) => const HomeScreen(),
            '/': (_) => const LoginScreen(),
            '/chat': (_) => const LoginScreen(),
            '/lang': (_) => const LanguageScreen(),
            '/register': (_) => const RegisterScreen(),
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                textStyle: TextStyles.boldText
              ),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}

