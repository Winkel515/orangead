import 'package:flutter/material.dart';

class ApiButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  ApiButton({
    this.child,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: RaisedButton(
        child: this.child,
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.orange,
          ),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
