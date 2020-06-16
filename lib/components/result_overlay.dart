import 'package:flutter/material.dart';

class ResultOverlay extends StatelessWidget {
  const ResultOverlay({
    @required this.showOverlay,
    @required this.overlayText,
  });

  final bool showOverlay;
  final String overlayText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: showOverlay,
          child: Opacity(
            opacity: 0.7,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        Visibility(
          visible: showOverlay,
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
      ],
    );
  }
}
