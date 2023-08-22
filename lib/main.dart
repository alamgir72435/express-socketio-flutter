import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    socket = io.io('http://192.168.0.102:5000', <String, dynamic>{
      'transports': ['websocket'], // websocket transport
    });

    socket.onConnect((data) {
      print('Connected to Server ');
    });

    socket.on('test-ev', (data) {
      print(data.toString());
    });

    socket.connect();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    socket.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Realtime Data Transfer'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Hello world')],
      ),
    );
  }
}
