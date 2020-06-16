import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'components/api_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool showOverlay = false;
  Timer inactivityTimer;
  int result;

  void fetchResult() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: "https://www.google.ca/"),
                  ),
                ),
                SizedBox(
                  width: 100,
                )
              ],
            ),
          ),
          Visibility(
            visible: showOverlay,
            child: Opacity(
              opacity: 0.7,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Text(
                    "Increased\nto result",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 60,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ApiButton(
                  onPressed: () {
                    if (inactivityTimer != null) inactivityTimer.cancel();
                    setState(() {
                      showOverlay = true;
                    });
                    inactivityTimer = new Timer(Duration(seconds: 5), () {
                      setState(() {
                        showOverlay = false;
                      });
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                ApiButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
