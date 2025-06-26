import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:map_pro/bloc/language/language_bloc.dart';
import 'package:map_pro/bloc/language/language_event.dart';
import 'package:map_pro/bloc/language/language_state.dart';
import 'package:map_pro/view/widgets/common_appBar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  final List<Map<String, dynamic>> languages = const [
    {'name': 'English', 'locale': Locale('en')},
    {'name': 'Arabic', 'locale': Locale('ar')},
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Scaffold(
      appBar: CommonAppBar(title: "Welcome",),

      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final lang = languages[index];
              final isSelected = lang['locale'] == currentLocale;

              return ListTile(
                title: Text(lang['name']),
                trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  context.read<LanguageBloc>().add(
                    ChangeLanguageEvent(locale: lang['locale'], context: context),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
