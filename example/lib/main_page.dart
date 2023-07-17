import 'dart:developer';

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
  void initState() {
    super.initState();
    viewModel.counter.observe(observerA);
    viewModel.counter.observe(observerB);
  }

  void observerA(int value) {
    log("counter value changed! $value", name: "Observer A");
  }

  void observerB(int value) {
    log("counter value changed! $value", name: "Observer B");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: Center(child: _counterSection()));
  }

  AppBar _appBar() => AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("View Model Kit Example"),
      );

  Widget _counterSection() =>
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        _defaultCounterSection(),
        const Divider(height: 48, thickness: 2),
        _counterWithSelectBuilderSection(),
      ]);

  Widget _defaultCounterSection() => Column(children: [
        const Text('You have pushed the button this many times:'),
        Text(
          '${viewModel.counter.value}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        textButton("Increment", onTap: viewModel.incrementCounter),
        textButton("Cancel Observer A", onTap: () {
          viewModel.counter.cancelObserve(observerA);
          log("Observer A is canceled!", name: "Observer A");
        }),
        textButton("Cancel Observer B", onTap: () {
          viewModel.counter.cancelObserve(observerB);
          log("Observer B is canceled!", name: "Observer B");
        }),
      ]);

  Widget _counterWithSelectBuilderSection() => Column(children: [
        SelectBuilder(
            rx: viewModel.counter2,
            builder: (context, value) {
              return Text('Counter2: $value',
                  style: Theme.of(context).textTheme.headlineSmall);
            }),
        textButton("decrease Counter2 (${viewModel.counter2.value})",
            onTap: viewModel.decreaseCounter2),
        textButton("rebuild! (setState)", onTap: () => setState(() {})),
      ]);

  Widget textButton(String text, {required VoidCallback onTap}) => Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(onPressed: onTap, child: Text(text)),
      );
}
