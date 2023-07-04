part of view_model_kit;

/// Use Instead of [State] with [StatefulWidget].
abstract class StateWithViewModel<T extends StatefulWidget,
    VM extends BaseViewModel> extends State<T> {
  late final VM viewModel = createViewModel().._setNotify(_notify);

  /// create [viewModel] instance.
  ///
  /// must be override.
  VM createViewModel();

  void _notify() {
    if (mounted) setState(() {});
  }
}
