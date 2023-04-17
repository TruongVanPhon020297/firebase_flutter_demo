import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'firebase_options.dart';

List<String> url = [];


// Future<List<String>> getData() async {
//   List<String> data = [];
//   final storageRef = await FirebaseStorage.instance.ref();
//
//    print("DATA LENGTH dsadasd" + data.length.toString());
//
//   storageRef.listAll().then((value){
//     value.prefixes.forEach((element) {
//       element.listAll().then((value){
//         value.items.forEach((element) {
//           element.getDownloadURL().then((value){
//             data.add(value);
//             print(value);
//           });
//         });
//       });
//     });
//   });
//
//   print("DATA LENGTH " + data.length.toString());
//
//   return data;
// }

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // final storageRef = FirebaseStorage.instance.ref();
  //
  // List data = [];
  //
  // await storageRef.listAll().then((value){
  //   value.prefixes.forEach((element) {
  //     print("ELEMENT --------- " + element.fullPath);
  //     data.add(element.fullPath);
  //   });
  // });
  //
  // List pathImage = [];
  //
  // List<Reference> listPathRef = [];
  //
  // await storageRef.child(data[0]).listAll().then((value){
  //   listPathRef = value.items;
  // });
  //
  // List<String> listFile = [];
  //
  // listPathRef.forEach((element) {
  //   listFile.add(element.fullPath);
  //   print("element.fullPath -------->" + element.fullPath);
  // });
  //
  // List<String> listPathImage = [];
  //
  // listFile.forEach((element) async{
  //   url.add(await storageRef.child(element).getDownloadURL());
  // });
  //
  // print("LENGTH --------------Path " + pathImage.length.toString());
  //
  //
  //
  // print("END---------------");





  // result.prefixes.forEach((Reference ref) {
  //   print('Found file: ${ref.fullPath}');
  //   FirebaseStorage.instance.ref().child(ref.fullPath).listAll().then((value){
  //     value.items.forEach((element) {
  //       element.getDownloadURL().then((value){
  //         url.add(value);
  //         print("IMAGE ---->" + value);
  //
  //       });
  //     });
  //   });
  // });

  // result.prefixes.forEach((Reference ref) {
  //   ref.listAll().then((value){
  //     value.items.forEach((element) {
  //       print("DASDASDASDASD " + element.fullPath);
  //       FirebaseStorage.instance.ref().child("images/${element.fullPath}").getDownloadURL().then((value){
  //         print("IMAGE ----> " + value);
  //
  //       });
  //     });
  //   });
  // });
//
//   ListResult result2 =
//   await FirebaseStorage.instance.ref().listAll();
//
//   result.prefixes.forEach((Reference ref) {
//     print('Found directory: ${ref}');
//   });
//
//   final resultImage = await  FirebaseStorage.instance.ref().child("images").listAll().then(
//           (value){
//             value.items.forEach((element) {
//               print("ITEMS    --------" + element.name);
//             });
//           }
//   );
//
//   final forestRef = storageRef.child("images/thong-bao.png");
//
// // Get metadata properties
//   final metadata = await forestRef.getDownloadURL().then((value){
//     print("IMAGE ----> " + value);
//     url.add(value);
//   });

//
//   print("META AAAAAAAA " + metadata.fullPath);


  print("LENGTH ---- " + url.length.toString());


  // Create a storage reference from our app
//   final storageRef2 = FirebaseStorage.instance.ref();
//
// // Create a reference to "mountains.jpg"
//   final mountainsRef = storageRef2.child("mountains.jpg");
//
// // Create a reference to 'images/mountains.jpg'
//   final mountainImagesRef = storageRef2.child("images/mountains.jpg");
//
// // While the file names are the same, the references point to different files
//   assert(mountainsRef.name == mountainImagesRef.name);
//   assert(mountainsRef.fullPath != mountainImagesRef.fullPath);






  final storageRef = FirebaseStorage.instance.ref().child("images");
  final listResult = await storageRef.listAll();
  // for (var prefix in listResult.prefixes) {
  //   print(prefix);
  // }


  for (var item in listResult.items) {
    await item.getDownloadURL().then((value) =>url.add(value));
  }

  // for (var item in listResult.items) {
  //   await FirebaseStorage.instance.ref().child(item.fullPath).delete();
  // }


  print("ENDDDDDDDD");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  late final Future<List<String>> listData;
  List<AssetEntity> _images = [];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _selectImages() async {
    List<AssetEntity>? result = await AssetPicker.pickAssets(context,
        pickerConfig: const AssetPickerConfig(
          maxAssets: 10,
          requestType: RequestType.image,
          selectedAssets: [],
        ));
    setState(() {
      _images = result!;
      _images.forEach((element) {_upload(element);});
    });
  }

  void _upload(AssetEntity file) async {
    // final storageRef = FirebaseStorage.instance.ref().child("images");
    // final listResult = await storageRef.listAll();
    // // for (var prefix in listResult.prefixes) {
    // //   print(prefix);
    // // }
    //
    //
    // for (var item in listResult.items) {
    //   await item.getDownloadURL().then((value) =>url.add(value));
    // }
    //
    //
    // // Create a storage reference from our app
    final storageRefUpload = FirebaseStorage.instance.ref();



// Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRefUpload.child("images/${DateTime.now()}");

    try {
      File? temp = await file.file;
      await mountainImagesRef.putFile(temp!);
      mountainImagesRef.getDownloadURL().then((value) => print(value));
    } on FirebaseException catch (e) {
      // ...
    }
  }

  @override
  void initState() {
    super.initState();
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
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: url.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    url[index],
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectImages,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



