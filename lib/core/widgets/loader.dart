import 'package:flutter/material.dart';
import 'package:webspark/core/extensions/theme_extension.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
    strokeWidth: 2,
    valueColor: AlwaysStoppedAnimation<Color>(color ?? context.colors.primary),
  );
}

extension LoaderX on BuildContext {
  void showLoader() => showDialog<void>(
    context: this,
    useRootNavigator: true,
    barrierDismissible: false,
    barrierColor: colors.scrim.withValues(alpha: 0.12),
    builder: (context) => const PopScope(canPop: false, child: Center(child: AppLoader())),
  );

  void debounceLoader({required bool? showLoader, required bool? popLoader}) {
    if (showLoader ?? false) return this.showLoader();
    if (popLoader ?? false) return Navigator.of(this, rootNavigator: true).pop();
  }
}

extension DebounceLoaderStateX<T> on T {
  void debounceLoaderWith(
    BuildContext context, {
    required T previous,
    bool Function(T state)? shouldShowLoader,
    bool Function(T state)? shouldPopLoader,
  }) {
    final showLoader = switch (this) {
      _ when shouldShowLoader?.call(this) ?? false => switch (previous) {
        _ when shouldShowLoader?.call(previous) ?? false => false,
        _ => true,
      },
      _ => null,
    };

    final popLoader = switch (previous) {
      _ when shouldPopLoader?.call(previous) ?? false => switch (this) {
        _ when shouldPopLoader?.call(this) ?? false => false,
        _ => true,
      },
      _ => null,
    };

    context.debounceLoader(showLoader: showLoader, popLoader: popLoader);
  }
}
