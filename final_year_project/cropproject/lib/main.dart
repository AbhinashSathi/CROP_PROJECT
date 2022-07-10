// ignore_for_file: deprecated_member_use

import 'package:cropproject/notifiction_page.dart';
import 'package:cropproject/services/local_noti.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {"page": (_) => NotificationPages()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var counter = "";
  final fdb = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.getInitialMessage().then((msg) {
      if (msg != null) {
        final routeMsg = msg.data["route"];
        print("routing" + routeMsg);
        Navigator.of(context).pushNamed(routeMsg);
      }
    });

    //foregroung
    FirebaseMessaging.onMessage.listen((msg) {
      if (msg.notification != null) {
        print(msg.notification!.title);
        print(msg.notification!.body);
      }

      LocalNotification.display(msg);
    });

    //runs in background open when taps
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      final routeMsg = msg.data["route"];

      print(routeMsg);
      Navigator.of(context).pushNamed(routeMsg);
    });

    FirebaseMessaging.instance.getToken().then((token) {
      DatabaseReference databaseReference = FirebaseDatabase().reference();
      databaseReference.child('/fcm-token/$token').set({"token": token});
      setState(() {
        counter = token.toString();
      });
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
