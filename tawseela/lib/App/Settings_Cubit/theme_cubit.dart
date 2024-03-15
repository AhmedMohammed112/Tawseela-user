import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/App/Shared_Preferences/shared.dart';
import 'package:tawseela/App/Settings_Cubit/theme_states.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeChangeModeState());
    }
    else {
      isDark = !isDark;
      SharedPref.saveData(key: 'IsDark', value: isDark).then((value) {
        emit(ThemeChangeModeState());
      });
    }
  }
}