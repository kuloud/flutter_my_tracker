import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('方框形状长按动画效果'),
        ),
        body: Center(
          child: MyFloatingActionButton(),
        ),
      ),
    );
  }
}

class MyFloatingActionButton extends StatefulWidget {
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool _isPressed = false;

  void _onPressed() {
    setState(() {
      _isPressed = true;
    });
  }

  void _onReleased() {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onPressed(),
      onTapUp: (_) => _onReleased(),
      onTapCancel: () => _onReleased(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: _isPressed ? 60 : 56,
        height: _isPressed ? 60 : 56,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(_isPressed ? 30 : 28),
          color: _isPressed ? Colors.blue : Colors.orange,
        ),
        child: _isPressed
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              )
            : Icon(
                Icons.add,
                color: Colors.white,
              ),
      ),
    );
  }
}
