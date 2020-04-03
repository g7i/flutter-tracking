//import 'dart:async';
//import 'dart:convert';
//import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//void write(lat, lon, name) {
//  final databaseReference = FirebaseDatabase.instance.reference();
//  databaseReference.child(name).set({'latitude': lat, 'longitude': lon});
//}
//
//Future<dynamic> read() {
//  final databaseReference = FirebaseDatabase.instance.reference();
//
////  data = databaseReference.onChildChanged.listen((event) {
////    print(event.snapshot);
////    return event.snapshot.value;
////  });
////  data = databaseReference.onChildAdded.listen((event) {
////    print(event.snapshot.value);
////    return event.snapshot.value;
////  });
//
//  var data = databaseReference.once().then((DataSnapshot snapshot) {
//    print('Data : ${snapshot.value}');
//    return snapshot.value;
//  });
//  return data;
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  var name = "";
//  SharedPreferences prefs;
//  Geolocator geolocator = Geolocator();
//
//  void _handleChange(namee) {
//    setState(() {
//      name = namee;
//    });
//  }
//
//  void _handleSubmit() {
//    prefs.setString('name', name);
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _sPref().then((val) {
//      setState(() {
//        prefs = val;
//        name = val.getString("name");
//      });
//
//      if (name != null) {
//        _locationOptions().then((locOpt) {
//          geolocator.getPositionStream(locOpt).listen((Position position) {
//            if (position != null) {
//              write(position.latitude, position.longitude, name);
//            }
//          });
//        });
//      }
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: getView(),
//    );
//  }
//
//  Widget getView() {
//    if (name == null) {
//      return Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'Enter a unique name:',
//            ),
//            TextField(
//              onChanged: _handleChange,
//              decoration: InputDecoration(contentPadding: EdgeInsets.all(20.0)),
//            ),
//            RaisedButton(
//              onPressed: _handleSubmit,
//              child: Text("Submit"),
//            ),
//          ],
//        ),
//      );
//    } else {
//      return FutureBuilder<dynamic>(
//        future: read(),
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            var keys = snapshot.data.keys.toList();
//            var vals = snapshot.data.values.toList();
//            return ListView.builder(
//              itemCount: snapshot.data.length,
//              itemBuilder: (context, position) {
//                return Card(
//                  child: Padding(
//                    padding: const EdgeInsets.all(16.0),
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                          keys[position],
//                          style: TextStyle(fontSize: 22.0),
//                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text(
//                          'Latitude : ${vals[position]['latitude']}, Longitude : ${vals[position]['longitude']}',
//                          style: TextStyle(fontSize: 12.0),
//                        ),
//                      ],
//                    ),
//                  ),
//                );
//              },
//            );
//          } else if (snapshot.hasError) {
//            return Text("${snapshot.error}");
//          }
//          return CircularProgressIndicator();
//        },
//      );
//    }
//  }
//
//  Future<LocationOptions> _locationOptions() async {
//    return LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 10);
//  }
//
//  Future<SharedPreferences> _sPref() async {
//    return SharedPreferences.getInstance();
//  }
//}
