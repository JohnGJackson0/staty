import 'bloc_exports.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<UpdateAppTheme>(_onUpdateTheme);
  }

  void _onUpdateTheme(UpdateAppTheme event, Emitter<ThemeState> emit) {
    final isDarkTheme = state.isDarkTheme;

    emit(ThemeState(isDarkTheme: !isDarkTheme));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
