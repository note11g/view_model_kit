import 'package:flutter/material.dart';
import 'package:view_model_kit/view_model_kit.dart';
import 'package:view_model_kit_example/main_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends StateWithViewModel<MainPage, MainViewModel> {
  @override
  MainViewModel createViewModel() => MainViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Center(child: _counterSection()),
        floatingActionButton: _floatingActionButton());
  }

  AppBar _appBar() => AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("View Model Kit Example"),
      );

  Widget _counterSection() =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('You have pushed the button this many times:'),
        Text(
          '${viewModel.counter.value}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ]);

  FloatingActionButton _floatingActionButton() => FloatingActionButton(
        onPressed: viewModel.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      );
}
