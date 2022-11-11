import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  final bool isDarkTheme;

  const ThemeState({this.isDarkTheme = true});

  @override
  List<Object> get props => [isDarkTheme];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDarkTheme': isDarkTheme,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      isDarkTheme: map['isDarkTheme'] as bool,
    );
  }
}
