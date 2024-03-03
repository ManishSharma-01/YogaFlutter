// import 'package:fitbit/features/routine/presentation/viewmodel/routine_view_model.dart';
// import 'package:fitbit/features/routine/presentation/widget/routine_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/routine_view_model.dart';
import '../widget/routine_card_widget.dart';

class RoutineView extends ConsumerStatefulWidget {
  const RoutineView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutineViewState();
}

class _RoutineViewState extends ConsumerState<RoutineView> {
  // @override
  // void initState() {
  //   super.initState();
  //   ref.read(routineViewModelProvider.notifier).getMyRoutines();
  // }

  @override
  Widget build(BuildContext context) {
    var routineState = ref.watch(routineViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Routines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (routineState.isLoading) ...{
                const CircularProgressIndicator(),
              } else if (routineState.error != null) ...{
                Text(routineState.error!),
              } else if (routineState.routines.isNotEmpty) ...{
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
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
                ),
              }
            ],
          ),
        ),
      ),
    );
  }
}
