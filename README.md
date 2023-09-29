# view_model_kit

[![pub package](https://img.shields.io/pub/v/view_model_kit.svg?color=4285F4)](https://pub.dev/packages/view_model_kit)

A simple and easy ViewModel and state management Library.

## How to use

see examples.

### 1. Setting StatefulWidget and Create ViewModel

`main_page.dart`

```dart
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
    return Scaffold();
  }
}
```

`main_view_model.dart`

```dart
class MainViewModel extends BaseViewModel {
  @override
  void onReady() {
    // onReady called only once when the ViewModel is ready. (first build)
  }
}
```

### 2. Use `R<V>` or `RList<V>` with ViewModel

```dart
class MainViewModel extends BaseViewModel {
  late final _count = createMutable(0); // can modify. (MutableR<V>)
  R<int> get count => _count; // can not modify. (R<V>)
  late final _todos = createMutableList<Todo>(); // or createMutableList<Todo>([]);
  RList<Todo> get todos => _todos; // can not modify. (RList<V>)

  @override
  void onReady() async {
    _count.value = 1; // auto rebuild.
    _count.value++; // auto rebuild.
    // count.value = 1; // error. because type of count is R<V>. use instead of MutableR<V>.value = 1;

    final todosFromRemote = await getTodosFromRemote();

    _todos.addAll([...todosFromRemote]); // auto rebuild.
    // todos.addAll([...todosFromRemote]); // error. because type of count is RList<V>. use instead of MutableRList<V>.addAll;

    //but...
    print(_todos.value); // ok
    print(_todos.value.addAll([...todos])); // not rebuild. use instead of todos.addAll([...todos]);
  }
}
```

### 3. Use `R<V>` or `RList<V>` with Widget (at `StateWithViewModel`)

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(chlidren: [
        Text("${viewModel.count.value}"),
        Text("${viewModel.todos.value}"),
      ]),
    ),
  );
}
```

### 4. Minimal rebuild

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(chlidren: [
        SelectBuilder(
          rx: viewModel.count,
          builder: (context, count) =>
              Text("$count (rebuild only this widget)"), // rebuild only (when updated)
        ),
        Text("${viewModel.count.value} (not rebuild)"),
      ]),
    ),
  );
}
```

### 5. Global State Manage Container

in this example, using [GetIt](https://pub.dev/packages/get_it).

```main_container.dart```

```dart
class MainContainer extends BaseContainer {
  late final _globalCount = createMutable(0);
  R<int> get globalCount => _globalCount;
  
  void incrementGlobalCount() {
    _globalCount.value++;
  }
}
```

```main.dart```

```dart
void main() {
  GetIt.instance.registerLazySingleton(() => MainContainer());
  // or, registerLazySingleton(MainContainer.new);
  runApp(MyApp());
}
```

```counter1_page.dart```

```dart
class Counter1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final container = GetIt.instance.get<MainContainer>();
    return Scaffold(
      body: Center(child: SelectBuilder(
        rx: container.globalCount,
        builder: (context, value) => ElevatedButton(
            child: Text("Page1 count up : $value"),
            onPressed: () => container.incrementGlobalCount()),
        ),
      ),
    );
  }
}
```

```counter2_page.dart```

```dart
class Counter2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final container = GetIt.instance.get<MainContainer>();
    return Scaffold(
      body: Center(child: SelectBuilder(
        rx: container.globalCount,
        builder: (context, value) => ElevatedButton(
            child: Text("Page2 count up : $value"),
            onPressed: () => container.incrementGlobalCount()),
        ),
      ),
    );
  }
}
```

### 6. Observer

```dart
class ObserveTestPage extends StatefulWidget {
  const ObserveTestPage({super.key});

  @override
  State<ObserveTestPage> createState() => _ObserveTestPageState();
}

class _ObserveTestPageState extends StateWithViewModel<ObserveTestPage, ObserveTestViewModel> {
  @override
  ObserveTestViewModel createViewModel() => ObserveTestViewModel();
  
  final mainContainer = GetIt.instance.get<MainContainer>();

  @override
  void initState() {
    super.initState();
    /// viewModel.counter lifecycle is same as this Stateful Widget. not has observer.
    viewModel.counter.observe((v) => print("counter value changed! : $v"));
    
    /// but, mainContainer.globalCount lifecycle is very different. (not depend on this Stateful Widget)
    /// that's means globalCount must be `cancelObserve` when dispose.
    mainContainer.globalCount.observe(observeGlobalCount);
  }
  
  void observeGlobalCount(int v) {
    print("globalCount value changed! : $v");
  }

  @override
  void dispose() {
    mainContainer.globalCount.cancelObserve(observeGlobalCount);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```
