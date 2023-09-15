import 'package:flutter/material.dart';
import 'package:kardone/utils/device.dart';
import 'package:kardone/widgets/base/widget_view_template.dart';

import 'arch/base_stateful_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseStatefulState<MyHomePage> with WidgetViewTemplate{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: showPage(context));
  }

  @override
  void initPresenter() {}

  @override
  Widget phoneView() {
    return Page1();
  }

  @override
  Widget tabletView() {
    return const Row(
      children: [
        Expanded(child: Page1()),
        Expanded(
          child: Page2(),
        )
      ],
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red,
        child: InkWell(
          child: Text("page1"),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Page2()));
          },
        ));
  }
}

class Page2 extends StatelessWidget {
  const Page2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.blue,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Page3()));
            },
            child: const Text("Page2"),
          )),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3();

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.amber, child: Text("Page3"));
  }
}
