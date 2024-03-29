import 'package:dartz/dartz.dart';
import 'package:fitbit/config/router/app_route.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/auth/domain/use_case/auth_usecase.dart';
import 'package:fitbit/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test/features/auth/presentation/view/login_view_test.mocks.dart';

// import 'register_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthUseCase>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;

  late UserEntity authEntity;

  setUpAll(
    () async {
      mockAuthUsecase = MockAuthUseCase();

      authEntity = const UserEntity(
        userID: null,
        firstname: 'Inish',
        lastname: 'Bashyal',
        image: '',
        age: '22',
        email: 'inish.bashyal99@gmail.com',
        gender: 'Male',
        username: 'Inish123',
        password: 'Inish123',
      );
    },
  );

  testWidgets('register view ...', (tester) async {
    when(mockAuthUsecase.registerUser(authEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUsecase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getAppRoutes(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Enter username in first textform field
    await tester.enterText(find.byType(TextFormField).at(0), 'Inish123');
    // Enter firstname in second textform field
    await tester.enterText(find.byType(TextFormField).at(1), 'Inish');
    // Enter lastname
    await tester.enterText(find.byType(TextFormField).at(2), 'Bashyal');
    // Enter email
    await tester.enterText(
        find.byType(TextFormField).at(3), 'inish.bashyal99@gmail.com');
    // Enter password
    await tester.enterText(find.byType(TextFormField).at(4), 'Inish123');
    //Enter age
    await tester.enterText(find.byType(TextFormField).at(5), '22');

    // For Gender
    final genderRowFinder = find.byType(Row).first;
    await tester.tap(find
        .descendant(
          of: genderRowFinder,
          matching: find.byType(Radio),
        )
        .first);
    // Tapping on the first Radio widget in the gender row
// Tapping on the first RadioListTile for "Male"
    await tester.pumpAndSettle();

    //=========================== Find the register button===========================
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    // Check weather the snackbar is displayed or not
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
