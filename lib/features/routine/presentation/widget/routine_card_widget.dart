import 'package:fitbit/config/constants/api_endpoint.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:fitbit/features/routine/presentation/viewmodel/routine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutineCardWidget extends ConsumerWidget {
  final int index;

  const RoutineCardWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routineState = ref.watch(routineViewModelProvider);
    final List<RoutineEntity> lstRoutine = routineState.routines;
    final RoutineEntity selectedRoutine = lstRoutine[index];

    final imageUrl = ApiEndpoints.imageUrl +
        (selectedRoutine.workout?.image ?? 'IMG-1690525395720.jpeg');

    return SizedBox(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 350,
          width: 300,
          child: Column(
            children: [
              Row(
                children: [
                  Image.network(
                    imageUrl,
                    width: 150,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedRoutine.workout?.title ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedRoutine.workout?.nameOfWorkout ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedRoutine.workout?.numberOfReps ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedRoutine.workout?.day ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedRoutine.routineStatus,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Show the "Mark as Complete" button only if the routine status is not "Completed"
                  if (selectedRoutine.routineStatus != 'Completed')
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        ref
                            .read(routineViewModelProvider.notifier)
                            .updateRoutine(context, selectedRoutine.routineId!);
                      },
                      child: const Text("Mark as Complete"),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      ref
                          .read(routineViewModelProvider.notifier)
                          .deleteRoutine(context, selectedRoutine);
                    },
                    child: const Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
