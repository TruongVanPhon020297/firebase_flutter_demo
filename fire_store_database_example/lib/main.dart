import 'package:fire_store_database_example/model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Student student = Student(
      fullName: "Nguyễn Văn D",
      delivery: Delivery(
          province: "Thừa Thiên",
          district: "Phú",
          ward: "Phú A"
      )
  );

  // await fireStore.collection("students").doc().set(student.toJson())
  // .then((value) => print("CREATE SUCCESS : ${fireStore.collection("students").doc().id}"));

  await fireStore.collection("students").add(student.toJson());

  // await fireStore.collection("students").get()
  // .then((value){
  //   value.docs.forEach((element) {
  //     students.add(Student.fromJson(element.data()));
  //   });
  // });
  //
  // print(students.length);
  //
  await fireStore.collection("students").orderBy('fullName').get()
      .then((value){
    value.docs.forEach((element) {
      print(element.data());
    });
  });

  // fireStore.collection("students").doc("oAxlr3eN0fdj9Qkumvno").update(student.toJson());

  // fireStore.collection("students").doc("15PtWwwDDEZOsolHotfY").delete();

  //
  // fireStore.collection("students").get()
  // .then((value){
  //   for(int i = 0; i < value.docs.length ; i++) {
  //     fireStore.collection("students").doc(value.docs[i].id).delete();
  //   }
  // });


  // fireStore.collection("students").doc("VCsxGXCiqbyTUt5U0hMo").delete();

  // fireStore.runTransaction((transaction) async {
  //   DocumentSnapshot snapshot = await transaction.get(fireStore.collection("students").doc("8jhhPs3BAwWH7cnPmuxX"));
  //
  //   if (!snapshot.exists) {
  //     throw Exception("Student does not exist!");
  //   }
  //
  //   // Perform an update on the document
  //   transaction.update(fireStore.collection("students").doc("8jhhPs3BAwWH7cnPmuxX"), {'fullName': "Họ Và Tên"});
  //
  //   // Return the new count
  //   return true;
  //
  // });

  runApp(const MyApp());
}


List<Student> students = [];

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
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              "${students[index].fullName} - ${students[index].delivery.province} - ${students[index].delivery.district} - ${students[index].delivery.ward}"
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
