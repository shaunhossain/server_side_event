import 'dart:async';
import 'package:flutter/material.dart';
import 'package:server_side_event/server_side_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
 late Stream response;

  getServerResponse(){
    final stream = ServerSiteEventConnect.connect(uri: 'https://www.w3schools.com/html/demo_sse.php', closeOnError: true);
    response = stream.streamController.stream.asBroadcastStream();
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
            // StreamBuilder(
            //   initialData: 0,
            //     stream: response,
            //     builder: (context, AsyncSnapshot<dynamic> snapshot){
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const CircularProgressIndicator();
            //       }
            //       return Text(
            //         snapshot.data!.toString(),
            //         style: const TextStyle(fontSize: 50, color: Colors.blue),
            //       );
            //     }),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'test',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
