import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'book_screen.dart';
import 'forms_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.usuarioId});

  final String usuarioId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _unfocusNode = FocusNode();
  late List<DocumentSnapshot> libros = [];

  @override
  void initState() {
    super.initState();
    obtenerLibros();
  }

  Future<void> obtenerLibros() async {
    final userDocRef =
        FirebaseFirestore.instance.collection('usuario').doc(widget.usuarioId);
    final librosCollectionRef = userDocRef.collection('libros');

    final querySnapshot = await librosCollectionRef.orderBy('titulo').get();

    // ignore: avoid_print
    print(widget.usuarioId);

    setState(() {
      libros = querySnapshot.docs;
    });
  }

  void navegaAAgregarLibro(BuildContext context) async {
    final mensaje = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookScreen(idUsuario: widget.usuarioId),
      ),
    );

    setState(() {
      obtenerLibros();
    });

    if (mensaje != null) {
      // ignore: use_build_context_synchronously
      mostrarSnackBar(context, mensaje);
    }
  }

  void navegaALibro(idLibro) async {
    final mensaje = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BookScreen(
                libroId: (idLibro),
                usuarioId: widget.usuarioId,
              )),
    );

    setState(() {
      obtenerLibros();
    });

    if (mensaje != null) {
      // ignore: use_build_context_synchronously
      mostrarSnackBar(context, mensaje);
    }
  }

  void mostrarSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF304E5D),
        content: Text(mensaje),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navegaAAgregarLibro(context);
          },
          tooltip: 'Agregar nuevo libro',
          backgroundColor: const Color(0xFF304E5D),
          elevation: 10,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        drawer: Drawer(
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.asset(
                      'assets/img/fondo-drawer.jpg',
                    ).image,
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 9.0),
                    child: Text(
                      'Acerca de',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              const Divider(
                thickness: 2,
                color: Color(0xFF304E5D),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: const Text(
                          'Biblioteca de bolsillo',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(),
                          child: const Text(
                            'Una aplicación que te permitirá comenzar tus primeros escritos, en un formato muy parecido al de una biblioteca real para una máxima experiencia.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(),
                          child: const Text(
                            'Datos del proyecto',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 185,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(),
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Autor: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Victor Manuel Gómez Solis',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(),
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Materia: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Fundamentos de desarrollo móvil',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(),
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Profesor: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Francisco Everardo Estrada Velázquez',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(),
                              child: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Institución: ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Universidad Autónoma de San Luis Potosí',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF304E5D),
          automaticallyImplyLeading: true,
          title: const Text(
            'Mi biblioteca',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
          elevation: 2,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset(
                    'assets/img/textura-biblioteca.jpg',
                  ).image,
                  fit: BoxFit.cover)),
          child: SafeArea(
            top: true,
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: libros.length,
                  itemBuilder: (context, index) {
                    final libro = libros[index];
                    final libroId = libro.id;
                    final nombreImagen = libro['nombre_imagen'];
                    final titulo = libro['titulo'];
                    final autor = libro['autor'];
                    final descripcion = libro['descripcion_corta'];

                    return InkWell(
                      onTap: () {
                        navegaALibro(libroId);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 10, 15, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/img/textura-libro.jpg',
                                ).image,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 180,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 130,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1,
                                        decoration: const BoxDecoration(),
                                        child: Image.asset(
                                          'assets/img/$nombreImagen',
                                          width: 130,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 7, 0),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                1,
                                            decoration: const BoxDecoration(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 3.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0x00FFFFFF),
                                                      ),
                                                      child: Text(
                                                        (titulo),
                                                        textAlign:
                                                            TextAlign.justify,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                    child: Text(
                                                      (autor),
                                                      textAlign: TextAlign.end,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    thickness: 1.4,
                                                    color: Color(0xFF304E5D),
                                                    height: 20.0,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                    child: Text(
                                                      (descripcion),
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 5,
                                                      style: const TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  /*children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BookScreen(
                                    libroId: '50',
                                  )),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 10, 15, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/img/textura-libro.jpg',
                                ).image,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 180,
                                  decoration: const BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 130,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1,
                                        decoration: const BoxDecoration(),
                                        child: Image.network(
                                          'https://picsum.photos/seed/400/600',
                                          width: 130,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              1,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 0, 7, 0),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.55,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                1,
                                            decoration: const BoxDecoration(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 3.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0x00FFFFFF),
                                                      ),
                                                      child: const Text(
                                                        'Alicia en el país de las maravillas',
                                                        textAlign:
                                                            TextAlign.justify,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                    child: const Text(
                                                      'Lewis Carroll',
                                                      textAlign: TextAlign.end,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                  const Divider(
                                                    thickness: 1.4,
                                                    color: Color(0xFF304E5D),
                                                    height: 20.0,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0x00FFFFFF),
                                                    ),
                                                    child: const Text(
                                                      'Lorem ipsum dolor sit amet consectetur adipiscing elit gravida, ac hendrerit sem libero penatibus varius. Lorem ipsum dolor sit amet consectetur adipiscing elit gravida, ac hendrerit sem libero penatibus varius.',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 5,
                                                      style: TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],*/
                ),
              ],
            ),
          ),
        ));
  }
}
