import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lamp/lamp.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.deepPurple[100]),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _filePath;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // return Scaffold(
    //   appBar: AppBar(
    //     // Here we take the value from the MyHomePage object that was created by
    //     // the App.build method, and use it to set our appbar title.
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     // Center is a layout widget. It takes a single child and positions it
    //     // in the middle of the parent.
    //     child: Column(
    //       // Column is also layout widget. It takes a list of children and
    //       // arranges them vertically. By default, it sizes itself to fit its
    //       // children horizontally, and tries to be as tall as its parent.
    //       //
    //       // Invoke "debug painting" (press "p" in the console, choose the
    //       // "Toggle Debug Paint" action from the Flutter Inspector in Android
    //       // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
    //       // to see the wireframe for each widget.
    //       //
    //       // Column has various properties to control how it sizes itself and
    //       // how it positions its children. Here we use mainAxisAlignment to
    //       // center the children vertically; the main axis here is the vertical
    //       // axis because Columns are vertical (the cross axis would be
    //       // horizontal).
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           'You have tekan pakai tangan the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.display1,
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );

    return new MaterialApp(
      //theme: new ThemeData(primarySwatch: Colors.pink),
      home: new Scaffold(
        appBar: new AppBar(title: new Text('FLESH LIGHT')),
        // appBar: AppBar(
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text(widget.title),
        // ),
        body: new SingleChildScrollView(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Card(
                  elevation: 12,
                  margin: EdgeInsets.fromLTRB(12, 24, 12, 12),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: <Widget>[
                        const ListTile(
                            leading: Icon(Icons.flash_auto),
                            title:
                                Text('Basic', style: TextStyle(fontSize: 24)),
                            subtitle: Text('Flasher.')),
                        new Text(
                            'Device has flash: $_hasFlash\n Flash is on: $_isOn'),
                        new Slider(
                            value: _intensity,
                            onChanged: _isOn ? _intensityChanged : null),
                        new RaisedButton(
                            onPressed: () async =>
                                await Lamp.flash(new Duration(seconds: 2)),
                            child: new Text("Flash for 2 seconds")),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 12,
                  margin: EdgeInsets.fromLTRB(12, 24, 12, 24),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(Icons.playlist_add),
                            title:
                                Text('Upload', style: TextStyle(fontSize: 24)),
                            subtitle: Text('Play Upload Song.')),
                        _filePath == null
                            ? new Text('No file selected.')
                            : new Text('Path' + _filePath),
                        new RaisedButton(
                            onPressed: getFilePath, child: new Text("Browse")),
                        new RaisedButton(
                            onPressed: discoFlash,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.play_circle_filled),
                                new Text(_isOn ? " Playing" : " Play")
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                            ))
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 12,
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 24),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: <Widget>[
                        const ListTile(
                            leading: Icon(Icons.record_voice_over),
                            title:
                                Text('Record', style: TextStyle(fontSize: 24)),
                            subtitle: Text('Recording Artist.')),
                        new RaisedButton(
                            onPressed: singFlash,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.fiber_manual_record),
                                new Text(_isOn
                                    ? " Recording ..."
                                    : " Start Recording")
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                            ))
                      ],
                    ),
                  ),
                ),
              ]),
        ),
        floatingActionButton: new FloatingActionButton(
            child: new Icon(_isOn ? Icons.flash_off : Icons.flash_on),
            onPressed: _turnFlash),
      ),
    );
  }

  Future onFlash({seconds = 0, milliseconds = 0}) async {
    return await Lamp.flash(
        new Duration(seconds: seconds, microseconds: milliseconds));
  }

  _turnFlashAMoment({seconds = 0, milliseconds = 0}) => () async {
        setState(() {
          _isOn = true;
        });

        onFlash(seconds: seconds, milliseconds: milliseconds).then((value) {
          setState(() {
            _isOn = false;
          });
        });
      };
  bool _hasFlash = false;
  bool _isOn = false;
  double _intensity = 1.0;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  discoFlash({duration = 20000}) async {
    if (!_isOn && duration != 20000) return;
    setState(() {
      _isOn = true;
    });
    int millis = Random().nextInt(600) + 100;
    int delayMillis = Random().nextInt(500) + 300;
    onFlash(milliseconds: millis).then((value) {
      Future.delayed(
          Duration(microseconds: delayMillis),
          () => duration - millis >= 0
              ? discoFlash(duration: duration - millis)
              : _turnFlashAMoment(milliseconds: duration)());
    });
  }

  singFlash({howmany = 3}) async {
    if (!_isOn && howmany != 3) return;
    setState(() {
      _isOn = true;
    });
    int millis = Random().nextInt(500) + 300;
    int delayMillis = Random().nextInt(300) + 100;
    onFlash(milliseconds: millis).then((value) {
      Future.delayed(
          Duration(milliseconds: delayMillis),
          () => howmany - 2 > 0
              ? singFlash(howmany: howmany - 1)
              : _turnFlashAMoment(milliseconds: millis)());
    });
  }

  initPlatformState() async {
    bool hasFlash = await Lamp.hasLamp;
    print("Device has flash ? $hasFlash");
    setState(() {
      _hasFlash = hasFlash;
    });
  }

  Future _turnFlash() async {
    _isOn ? Lamp.turnOff() : Lamp.turnOn(intensity: _intensity);
    var f = await Lamp.hasLamp;
    setState(() {
      _hasFlash = f;
      _isOn = !_isOn;
    });
  }

  _intensityChanged(double intensity) {
    Lamp.turnOn(intensity: intensity);
    setState(() {
      _intensity = intensity;
    });
  }

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(() {
        this._filePath = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }
}
