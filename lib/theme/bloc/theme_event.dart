import 'package:equatable/equatable.dart';

class ThemeEvent extends Equatable {
  final bool isDarkTheme;

  const ThemeEvent({this.isDarkTheme = true});

  @override
  List<Object> get props => [isDarkTheme];
}

class UpdateAppTheme extends ThemeEvent {
  final bool newThemeIsDark;

  const UpdateAppTheme({required this.newThemeIsDark});

  @override
  List<Object> get props => [newThemeIsDark];
}
