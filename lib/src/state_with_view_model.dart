part of view_model_kit;

/// Use Instead of [State] with [StatefulWidget].
abstract class StateWithViewModel<T extends StatefulWidget,
    VM extends BaseViewModel> extends State<T> {
  /// [viewModel] instance.
  late final VM viewModel = createViewModel()
    .._setNotifyAtStatefulWidget(_notifyAtThisWidget);

  /// create [viewModel] instance.
  ///
  /// must be override.
  VM createViewModel();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _notifyAtThisWidget() {
    if (mounted) setState(() {});
  }
}
