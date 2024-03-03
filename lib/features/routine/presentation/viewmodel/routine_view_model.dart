import 'package:fitbit/core/common/snackbar/my_snackbar.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:fitbit/features/routine/domain/use_case/routine_use_case.dart';
import 'package:fitbit/features/routine/presentation/state/routine_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routineViewModelProvider =
    StateNotifierProvider<RoutineViewModel, RoutineState>(
  (ref) {
    return RoutineViewModel(ref.read(routineUsecaseProvider));
  },
);

class RoutineViewModel extends StateNotifier<RoutineState> {
  final RoutineUseCase routineUseCase;
  @override
  void init() {
    getMyRoutines();
  }

  RoutineViewModel(this.routineUseCase)
      : super(const RoutineState(isLoading: false)) {
    getMyRoutines();
  }

  addRoutine(RoutineEntity routine, BuildContext context) async {
    state.copyWith(isLoading: true);
    var data = await routineUseCase.addRoutine(routine);

    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
    }, (r) {
      state.routines.add(routine);
      state = state.copyWith(isLoading: false, error: null);
      showSnackBar(message: 'Added to your routine', context: context);
    });
  }

  getAllRoutines() async {
    state = state.copyWith(isLoading: true);
    var data = await routineUseCase.getAllRoutines();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, routines: r, error: null),
    );
  }

  Future<void> deleteRoutine(
      BuildContext context, RoutineEntity routine) async {
    state.copyWith(isLoading: true);
    var data = await routineUseCase.deleteRoutine(routine.routineId!);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.routines.remove(routine);
        state = state.copyWith(
            isLoading: false, error: null, routines: state.routines);
        showSnackBar(
          message: 'Workout delete successfully',
          context: context,
        );
      },
    );
  }

  Future<void> updateRoutine(BuildContext context, String routineId) async {
    state.copyWith(isLoading: true);

    int index =
        state.routines.indexWhere((element) => element.routineId == routineId);
    if (index < 0) {
      state = state.copyWith(
          isLoading: false, error: "Routine not found in the list.");
      return;
    }

    if (state.routines[index].routineStatus == 'Completed') {
      state = state.copyWith(
          isLoading: false,
          error: "Routine is already marked as complete.",
          routines: state.routines);
      return;
    }

    var data = await routineUseCase.updateRoutine(routineId);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);
        state = state.copyWith(isLoading: false);
      },
      (r) {
        RoutineEntity updatedRoutine = state.routines[index].copyWith(
          routineStatus: 'Completed',
        );
        state.routines[index] = updatedRoutine;

        state = state.copyWith(isLoading: false, routines: state.routines);

        showSnackBar(
          message: 'Routine marked as complete successfully',
          context: context,
        );
      },
    );
  }

  Future<void> getMyRoutines() async {
    state = state.copyWith(isLoading: true);
    var data = await routineUseCase.getMyRoutines();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (routines) {
        state =
            state.copyWith(isLoading: false, routines: routines, error: null);
      },
    );
  }
}
