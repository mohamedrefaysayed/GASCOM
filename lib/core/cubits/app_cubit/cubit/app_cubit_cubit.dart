import 'package:bloc/bloc.dart';

part 'app_cubit_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppCubitInitial());

  static String? token;
}
