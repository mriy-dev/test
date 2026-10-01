import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:webspark/boot/boot.dart';
import 'package:webspark/core/validators/app_reactive_validators.dart';
import 'package:webspark/core/widgets/loader.dart';
import 'package:webspark/core/widgets/primary_button.dart';
import 'package:webspark/feature/home/presentation/cubit/home_cubit.dart';
import 'package:webspark/feature/process/presentation/process_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cubit = get<HomeCubit>();

  late final _form = FormGroup({
    AppReactiveValidatorsKeys.baseUrlKey: FormControl<String>(
      value: _cubit.state.baseUrl,
      validators: [Validators.delegate(AppReactiveValidators.baseUrl)],
    ),
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: _cubit,
      listenWhen: _debounceLoader,
      listener: (context, state) => switch (state) {
        HomeFailure(:final message) =>
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message))),
        HomeSuccess(:final tasks) => Navigator.of(
          context,
        ).push(MaterialPageRoute<void>(builder: (_) => ProcessScreen(tasks: tasks))),
        _ => null,
      },

      builder: (context, state) {
        return ReactiveForm(
          formGroup: _form,
          child: Scaffold(
            appBar: AppBar(title: const Text('Home Screen')),
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AppPrimaryButton(label: 'Start counting process', onTap: _onStart),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              physics: const ClampingScrollPhysics(),
              children: [
                const Text('Set a valid Api base Url in order to continue'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 12), child: Icon(Icons.read_more)),
                    Expanded(
                      child: ReactiveTextField<String>(
                        formControlName: AppReactiveValidatorsKeys.baseUrlKey,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _onStart(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onStart() {
    _form.markAllAsTouched();
    if (_form.invalid) return;

    _cubit.setBaseUrl(url: _baseUrlControl.value ?? '');
  }

  FormControl<String> get _baseUrlControl =>
      _form.control(AppReactiveValidatorsKeys.baseUrlKey) as FormControl<String>;

  bool _debounceLoader(HomeState previous, HomeState current) {
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
    _form.dispose();
    _cubit.close();
    super.dispose();
  }
}
