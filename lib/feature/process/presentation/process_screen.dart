import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/boot/boot.dart';
import 'package:webspark/core/extensions/process_state_extension.dart';
import 'package:webspark/core/extensions/theme_extension.dart';
import 'package:webspark/core/widgets/loader.dart';
import 'package:webspark/core/widgets/primary_button.dart';
import 'package:webspark/core/widgets/progress_ring.dart';
import 'package:webspark/feature/home/domain/models/task_model.dart';
import 'package:webspark/feature/process/presentation/cubit/process_cubit.dart';
import 'package:webspark/feature/result/presentation/result_list_screen.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key, required this.tasks});

  final List<TaskModel> tasks;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  late final _cubit = get<ProcessCubit>()..findPaths(widget.tasks);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProcessCubit, ProcessState>(
      bloc: _cubit,
      listenWhen: _debounceLoader,
      listener: (context, state) {
        if (state case ProcessSuccess(:final results, checks: != null)) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute<void>(builder: (_) => ResultListScreen(results: results)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Process screen')),
          floatingActionButton: !state.canShowAction
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppPrimaryButton(
                    label: 'Send results to server',
                    onTap: state.canSend ? _cubit.send : null,
                  ),
                ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  state.statusText,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: state.progress.toDouble()),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => Text(
                    '${value.round()}%',
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 12),
                Center(child: ProgressRing(progress: state.progress / 100)),
                if (state.errorMessage case final message?) ...[
                  const SizedBox(height: 24),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(color: context.colors.error),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  bool _debounceLoader(ProcessState previous, ProcessState current) {
    current.debounceLoaderWith(
      context,
      previous: previous,
      shouldShowLoader: (state) => state.isBusy,
      shouldPopLoader: (state) => state.isBusy,
    );

    return true;
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
