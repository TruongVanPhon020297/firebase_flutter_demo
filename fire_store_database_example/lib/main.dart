import 'package:fire_store_database_example/model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();



  // Student student = Student(
  //     fullName: "Nguyễn Văn D",
  //     delivery: Delivery(
  //         province: "Thừa Thiên",
  //         district: "Phú",
  //         ward: "Phú A"
  //     )
  // );
  //
  // // await fireStore.collection("students").doc().set(student.toJson())
  // // .then((value) => print("CREATE SUCCESS : ${fireStore.collection("students").doc().id}"));
  //
  // await fireStore.collection("students").add(student.toJson());
  //
  // // await fireStore.collection("students").get()
  // // .then((value){
  // //   value.docs.forEach((element) {
  // //     students.add(Student.fromJson(element.data()));
  // //   });
  // // });
  // //
  // // print(students.length);
  // //

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String id = "";

   await fireStore.collection("hospitals").add(
    Hospital(
        image: "Image",
        address: "address",
        star: 4,
        hospitalName: "hospitalName",
        information: "information",
        knowledges: ["A","B","C"],
        operatingTime: "operatingTime",
        service: ["1","2","3"]
    ).toJson()
  ).then((value) {
    id = value.id;
  });

  await fireStore.collection("hospitals").doc(id).collection("doctors").add(
    {"full_name": "Trương Văn P", "star": 4, "years_of_experience": 7, "Information": "Cloud Firestore có thể được coi là phiên bản cải tiến của Realtime database, nó được cải tiến nhiều tính năng mới và tăng tốc độ truy vấn dữ liệu. Nếu bạn đang sử dụng Realtime Database thì việc chuyển sang sử dụng Cloud firestore khá dễ dàng", "knowledges": "[Chứng Chỉ 1, Chứng Chỉ 2]"}
  );

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

Future<List<Hospital>> getAllHospital() async {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<Hospital> hospitals = [];

  List<String> listId = [];

  await fireStore.collection("hospitals").get()
      .then((value){
    for (var element in value.docs) {
      hospitals.add(Hospital.fromJson(element.data()));
      listId.add(element.id);
    }
  });

  for(var e in listId) {
    await fireStore.collection("hospitals").doc(e).collection("doctors").get()
        .then((value){
      value.docs.forEach((element) {
        print("doctor ${element.data()}");
      });
    });
  }

  return hospitals;
}


Future<List> getAllDoctor() async {

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  List<Hospital> hospitals = [];

  List<String> listId = [];

  await fireStore.collection("hospitals").get()
      .then((value){
    for (var element in value.docs) {
      hospitals.add(Hospital.fromJson(element.data()));
      listId.add(element.id);
    }
  });

  List listData = [];

  for(var e in listId) {
    await fireStore.collection("hospitals").doc(e).collection("doctors").get()
        .then((value){
      value.docs.forEach((element) {
        print("doctor ${element.data()}");
        listData.add(element.data());
      });
    });
  }

  return listData;
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

  late Future<List<Hospital>> _future;

  bool isLoading = false;

  List<Hospital> list = [];

  List list1 = [];

  @override
  void initState() {
    super.initState();
    _future = getAllHospital();

    (() async {

      list = await getAllHospital();

      list1 = await getAllDoctor();

      print("LENGTH ${list1.length}");

      for (var element in list1) {
        print(element);
      }

      setState(() {
        isLoading = true;
      });

    })();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: isLoading ? ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) => Text(
                "${list[index].address} ${list[index].service} ${list[index].operatingTime} ${list[index].knowledges[1]} ${list[index].information} ${list[index].star}"
            ),
      ) : const CircularProgressIndicator()),
      //   child: FutureBuilder<List<Hospital>>(
      //     future: _future,
      //     builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator(),);
      //     } else if (snapshot.hasError) {
      //       return Center(child:  Text(snapshot.error.toString()),);
      //     } else {
      //       return ListView.builder(
      //         itemCount: snapshot.data!.length,
      //         itemBuilder: (context, index) => Text(
      //             "${snapshot.data![index].address} ${snapshot.data![index].service} ${snapshot.data![index].operatingTime} ${snapshot.data![index].knowledges[1]} ${snapshot.data![index].information} ${snapshot.data![index].star}"
      //         ),
      //       );
      //     }
      //     },
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
