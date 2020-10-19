import 'package:flutter/material.dart';
import 'package:integracion_otro_intento/utilidad.dart';
import 'package:integracion_otro_intento/widgets/widget_a_imagen.dart';
import 'package:integracion_otro_intento/widgets/drag_box.dart';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'integracion2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Integracion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color caughtColor = Colors.grey;
  GlobalKey key1;
  GlobalKey key2;
  GlobalKey key3;
  Uint8List bytes1;
  Uint8List bytes2;
  Uint8List bytes3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          WidgetToImage(
            builder: (key) {
              this.key1 = key;
              //return DragBox(Offset(10.0, 100.0), 'Azul', Colors.blue);
              return Positioned(
                left: 110.0,
                bottom: 120.0,
                child: DragTarget(
                  onAccept: (Color color) {
                    caughtColor = color;
                  },
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        color: accepted.isEmpty
                            ? caughtColor
                            : Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Text("Aca mueva el color"),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          WidgetToImage(
            builder: (key) {
              this.key2 = key;
              return DragBox(Offset(125.0, 500.0), 'Naranjo', Colors.orange);
            },
            /* WidgetToImage(
            builder: (key) {
              this.key3 = key;
              return DragBox(Offset(225.0, 500.0), 'Verder', Colors.green);
            },*/
          ),
          buildImage(bytes1),
          // buildImage(bytes2),
          //buildImage(bytes3),
        ],
      ),
      bottomSheet: Container(
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          child: RaisedButton(
            color: Colors.white,
            child: Text('Transformar a imagen'),
            onPressed: () async {
              final bytes1 = await Utils.capture(key1);
              //final bytes2 = await Utils.capture(key2);
              // final bytes3 = await Utils.capture(key3);

              setState(() {
                this.bytes1 = bytes1;
                // this.bytes2 = bytes2;
                //this.bytes3 = bytes3;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();
}
