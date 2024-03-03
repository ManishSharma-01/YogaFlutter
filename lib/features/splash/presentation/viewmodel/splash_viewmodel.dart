import 'package:fitbit/config/router/app_route.dart';
import 'package:fitbit/core/shared_prefs/user_shared_prefs.dart';
import 'package:fitbit/features/auth/domain/use_case/auth_usecase.dart';
import 'package:fitbit/features/splash/presentation/state/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
      ref.read(authUseCaseProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<SplashState> {
  final AuthUseCase _authUseCase;
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs, this._authUseCase)
      : super(SplashState.initial());

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          // We will not do navigation like this,
          // we will use mixin and navigator class for this
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        } else {
          Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      }
    });
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // 10 digit
    int expirationTimestamp = decodedToken['exp'];
    // 13
    final currentDate = DateTime.now().millisecondsSinceEpoch;
    // If current date is greater than expiration timestamp then token is expired
    return currentDate > expirationTimestamp * 1000;
  }

  // Future<String> isUser(String token) async {
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //   String user = decodedToken['userID'];
  //   return user;
  // }

  // Future<void> getUser(String userID) async {
  //   state = state.copyWith(isLoading: true);
  //   var data = await _authUseCase.getUser();
  //   data.fold(
  //     (failure) {
  //       state = state.copyWith(isLoading: false, error: failure.error);
  //     },
  //     (success) {
  //       state = state.copyWith(isLoading: false, user: success, error: null);
  //     },
  //   );
  // }

  // void getUserInfo(String token) {
  //   Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //   String currentuser = decodedToken['userID'];
  //   getUser(currentuser);
  // }
}
