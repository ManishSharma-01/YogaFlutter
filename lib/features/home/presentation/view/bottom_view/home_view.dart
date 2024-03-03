// Import the cached_network_image package
import 'package:fitbit/config/constants/api_endpoint.dart';
import 'package:fitbit/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:fitbit/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:fitbit/features/routine/presentation/viewmodel/routine_view_model.dart';
import 'package:fitbit/features/routine/presentation/widget/routine_card_widget.dart';
import 'package:fitbit/features/workout/presentation/viewmodel/workout_view_model.dart';
import 'package:fitbit/features/workout/presentation/widget/local_workout_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  var gap = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);
    final wokroutState = ref.watch(workoutViewModelProvider);
    final routineState = ref.watch(routineViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileView(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        ApiEndpoints.imageUrl + (authState.user?.image ?? ''),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                'New routines',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      for (int i = 0;
                          i < wokroutState.workouts.length;
                          i++) ...{
                        WorkoutLocalCard(index: i),
                      },
                    ],
                  ),
                ),
              ),
              const Text(
                'Popular ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      for (int i = 0;
                          i < routineState.routines.length;
                          i++) ...{
                        RoutineCardWidget(
                          index: i,
                        ),
                      },
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
