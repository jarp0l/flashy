import 'package:flutter/material.dart';
import 'package:flutter_flashlight/flutter_flashlight.dart';

void main() => runApp(FlashyApp());

class FlashyApp extends StatelessWidget {
  const FlashyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flashy'),
          centerTitle: true,
        ),
        body: MainBody(),
      ),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  bool _hasFlashlight = false;
  bool _isOn = false;

  @override
  initState() {
    super.initState();
    initFlashlight();
  }

  initFlashlight() async {
    bool _hasFlash = await Flashlight.hasFlashlight;
    // print("Device has flash ? $_hasFlash");
    setState(() {
      _hasFlashlight = _hasFlash;
    });
  }

  void switchLamp() {
    setState(() {
      if (_isOn)
        Flashlight.lightOff();
      else
        Flashlight.lightOn();
      _isOn = !_isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _hasFlashlight
              ? 'Your phone has Flashlight.'
              : 'Your phone has no Flashlight.',
          style: TextStyle(
              color: _hasFlashlight ? Colors.green[500] : Colors.red,
              fontSize: 16.0),
        ),
        FloatingActionButton(
            elevation: 30.0,
            backgroundColor: _isOn ? Colors.amber[500] : Colors.white,
            onPressed: switchLamp,
            child:
                _isOn ? Icon(Icons.lightbulb) : Icon(Icons.lightbulb_outline)),
        Text(
          _isOn ? 'On' : 'Off',
          // textScaleFactor: 5.0,
          style: TextStyle(
              color: _isOn ? Colors.green[700] : Colors.white, fontSize: 48.0),
        ),
      ],
    ));
  }
}
