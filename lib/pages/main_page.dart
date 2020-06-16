import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:orangead/components/api_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum ButtonAction { increase, decrease }

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool showOverlay = false;
  Timer inactivityTimer;
  String overlayText = "";

  void fetchResult(ButtonAction buttonAction) async {
    var response = await http.get(
        'https://jpv72utuoa.execute-api.us-east-1.amazonaws.com/v1//groups/1BE02595-716B-4D2F-B5F1-DAA878DBC1F2/counter/capacity?op=+');
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body)['result'];
      setState(() {
        if (buttonAction == ButtonAction.increase)
          overlayText = "Increased\nto $result";
        else if (buttonAction == ButtonAction.decrease)
          overlayText = "Decreased\nto $result";
        else {
          overlayText = "Unexpected ButtonAction in fetchResult";
        }
        showOverlay = true; // Wait for result before displaying the overlay
      });
    } else {
      setState(() {
        overlayText =
            "Error in the request. Status code: ${response.statusCode}";
      });
    }
  }

  void increaseButtonPress() {
    fetchResult(ButtonAction.increase);
    setInactivityTimer();
  }

  void decreaseButtonPress() {
    fetchResult(ButtonAction.decrease);
    setInactivityTimer();
  }

  void setInactivityTimer() {
    if (inactivityTimer != null)
      inactivityTimer.cancel(); // Cancelling timer so to not fire early
    inactivityTimer = new Timer(Duration(seconds: 5), () {
      setState(() {
        showOverlay =
            false; // Remove overlay when 5 seconds of inactivity are up
      });
    });
  }

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
                    overlayText,
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
                    fetchResult(ButtonAction.increase);
                    if (inactivityTimer != null) inactivityTimer.cancel();
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
                  onPressed: () {
                    decreaseButtonPress();
                  },
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
