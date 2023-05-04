import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:pip_flutter/main.dart';
import 'package:pip_flutter/pip_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Floating floating;
  List<int> aspectRatio = aspectRatios.first;
  bool isPipAvailable = false;

  @override
  void initState() {
    floating = Floating();
    requestPipAvailable();
    super.initState();
  }

  void requestPipAvailable() async {
    isPipAvailable = await floating.isPipAvailable;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PiPSwitcher(
      childWhenEnabled: Scaffold(
        appBar: AppBar(
          title: const Text("Pip Mode"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              width: double.infinity,
            ),
            Text("Pip is activated")
          ],
        ),
      ),
      childWhenDisabled: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Pip View"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PipPlayer()),
                );
              },
              icon: const Icon(Icons.video_collection_rounded),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            Text("Pip is $isPipAvailable"),
            DropdownButton<List<int>>(
              value: aspectRatio,
              items: aspectRatios
                  .map<DropdownMenuItem<List<int>>>((List<int> value) =>
                      DropdownMenuItem<List<int>>(
                          value: value,
                          child: Text("${value.first} : ${value.last}")))
                  .toList(),
              onChanged: (List<int>? newValue) {
                if (newValue == null) return;
                aspectRatio = newValue;
                setState(() {});
              },
            ),
            IconButton(
              onPressed: isPipAvailable
                  ? () => floating.enable(
                        aspectRatio: Rational(aspectRatio[0], aspectRatio[1]),
                      )
                  : null,
              icon: const Icon(Icons.picture_in_picture_rounded),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    floating.dispose();
    super.dispose();
  }
}
