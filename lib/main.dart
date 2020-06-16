import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {},
                    child: Text('+'),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('-'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
