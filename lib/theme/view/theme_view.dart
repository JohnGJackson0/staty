import 'package:flutter/material.dart';

import '../bloc/bloc_exports.dart';

class ThemeView extends StatefulWidget {
  const ThemeView({super.key});

  @override
  State<ThemeView> createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  // should be based on system theme for ios
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(child: Text('Dark Mode')),
                  Flexible(
                    child: Switch(
                        value: state.isDarkTheme,
                        onChanged: (value) {
                          context
                              .read<ThemeBloc>()
                              .add(UpdateAppTheme(newThemeIsDark: value));
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
