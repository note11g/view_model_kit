part of view_model_kit;

/// SelectBuilder Widget can be used to build only this widget.
///
/// useful when you want to rebuild only this widget. (least rebuild)
class SelectBuilder<V> extends StatefulWidget {
  final BaseR<V> rx;
  final Function(BuildContext context, V value) builder;

  const SelectBuilder({
    super.key,
    required this.rx,
    required this.builder,
  });

  @override
  State<SelectBuilder<V>> createState() => _SelectBuilderState<V>();
}

class _SelectBuilderState<V> extends State<SelectBuilder<V>> {
  @override
  void initState() {
    widget.rx._observeWithSelectBuilder(_notifyAtThisWidget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.rx.value);
  }

  @override
  void dispose() {
    widget.rx._cancelObserverWithSelectBuilder(_notifyAtThisWidget);
    super.dispose();
  }

  void _notifyAtThisWidget(V value) {
    if (mounted) setState(() {});
  }
}
