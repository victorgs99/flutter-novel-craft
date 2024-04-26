/*
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  Future registrar() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final json = {
      'nombre': controller1.text,
      'edad': controller2.text,
      'correo': controller3.text
    };
    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text('Nombre  '),
                Container(
                  height: 50,
                  width: 200,
                  child: TextField(
                    controller: controller1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Nombre del usuario',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text('Edad  '),
                Container(
                  height: 50,
                  width: 200,
                  child: TextField(
                    controller: controller2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Edad del usuario',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text('Correo  '),
                Container(
                  height: 50,
                  width: 200,
                  child: TextField(
                    controller: controller3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Correo del usuario',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 900,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('No hay informacion');
                  } else {
                    var items = snapshot.data?.docs;
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data?.docs[index]
                              as DocumentSnapshot<Object?>;
                          return ElevatedButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(ds.id)
                                    .delete();
                              },
                              child: Text(ds["nombre"] +
                                  ' ' +
                                  ds["correo"] +
                                  " " +
                                  ds["edad"] +
                                  " " +
                                  ds.id));
                        });
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          registrar();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

*/