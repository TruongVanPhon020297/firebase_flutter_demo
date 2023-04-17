import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database_example/model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


List<Student> students = [];

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseDatabase database = FirebaseDatabase.instance;

  DatabaseReference reference = database.ref("student").push();

  Student student = Student(
      id: reference.key.toString(),
      fullName: "",
      address: "HỒ"
  );

  DatabaseReference referenceTransaction = database.ref("student/-NR0i552ghzAAUR-aSsO");

  // referenceTransaction.runTransaction((value){
  //
  //   if(value != null) {
  //     Student student = value as Student;
  //
  //   }
  //
  // });
  //

  // referenceTransaction.remove()
  //     .then((_) => print("SUCCESS"))
  //     .catchError((e) => print(e.toString()));



  // reference.set(student.toJson())
  //     .then((_) => print("SUCCESS : ${reference.key}"))
  //     .catchError((e) => print(e.toString()));




  DatabaseReference referenceData = database.ref("student").orderByValue().ref;

  var snapshot = await referenceData.get();

  if(snapshot.exists) {
    Map data = snapshot.value as Map;
    data.forEach((key, value) {
      students.add(Student.fromJson(value));
    });
    print(data);

    print(students.length);

  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) => Container(
            color: Colors.red,
            child: Column(
              children: [
                Text("${students[index].id} - ${students[index].fullName} - ${students[index].address}"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
