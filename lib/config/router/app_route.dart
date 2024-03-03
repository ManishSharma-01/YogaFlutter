import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
import '../../features/home/presentation/view/bottom_view/add_workout_view.dart';
import '../../features/home/presentation/view/dashboard_view.dart';
import '../../features/splash/presentation/view/splash_screen.dart';

class AppRoute {
  AppRoute._();

  static const String loginRoute = '/';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String splashRoute = '/splash';
  static const String addWorkoutRoute = '/addWorkout';

  static getAppRoutes() {
    return {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      dashboardRoute: (context) => const DashboardView(),
      splashRoute: (context) => const SplashScreenView(),
      addWorkoutRoute: (context) => const AddWorkoutView(),
    };
  }
}
