import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/splash/presentation/pages/splash_states.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    await Future.delayed(const Duration(seconds: 2)); // Duración del splash
    emit(SplashFinished());
  }
}
