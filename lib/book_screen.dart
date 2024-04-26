import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'forms_screen.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key, required this.libroId, required this.usuarioId});

  final String usuarioId;
  final String libroId;

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final _unfocusNode = FocusNode();
  DocumentSnapshot? libro;
  List<DocumentSnapshot>? capitulos;

  @override
  void initState() {
    super.initState();
    obtenerLibro();
  }

  Future<void> obtenerLibro() async {
    final userDocRef =
        FirebaseFirestore.instance.collection('usuario').doc(widget.usuarioId);
    final libroDocRef = userDocRef.collection('libros').doc(widget.libroId);

    final libroSnapshot = await libroDocRef.get();
    final capitulosSnapshot = await libroDocRef
        .collection('capitulos')
        .orderBy('nombre_capitulo')
        .get();

    setState(() {
      libro = libroSnapshot;
      capitulos = capitulosSnapshot.docs;
    });
  }

  void navegaAEditarFicha(BuildContext context) async {
    final mensaje = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditFichaScreen(
            libro: libro!,
            usuarioId: widget.usuarioId), // Pasa los datos a editar
      ),
    );

    setState(() {
      obtenerLibro();
    });

    if (mensaje != null) {
      // ignore: use_build_context_synchronously
      mostrarSnackBar(context, mensaje);
    }
  }

  void navegaAAgregarCapitulo(BuildContext context) async {
    final mensaje = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookChapterScreen(
            libroId: widget.libroId,
            usuarioId: widget.usuarioId), // Pasa los datos a editar
      ),
    );

    setState(() {
      obtenerLibro();
    });

    if (mensaje != null) {
      // ignore: use_build_context_synchronously
      mostrarSnackBar(context, mensaje);
    }
  }

  Future<void> eliminarCapitulo(String capituloId) async {
    try {
      // Obtén una referencia al documento del usuario
      DocumentReference usuarioRef = FirebaseFirestore.instance
          .collection('usuario')
          .doc(widget.usuarioId);

      // Obtén una referencia al documento del libro
      DocumentReference libroRef =
          usuarioRef.collection('libros').doc(widget.libroId);

      // Elimina el capítulo
      await libroRef.collection('capitulos').doc(capituloId).delete();
      setState(() {
        obtenerLibro();
      });
      // ignore: use_build_context_synchronously
      mostrarSnackBar(context, '¡El capítulo ha sido eliminado con éxito!');
    } catch (error) {
      mostrarSnackBar(context, 'Ha ocurrido un error. Intentalo mas tarde.');
    }
  }

  Future<void> eliminarCapitulos() async {
    try {
      QuerySnapshot capitulosSnapshot = await FirebaseFirestore.instance
          .collection('usuario')
          .doc(widget.usuarioId)
          .collection('libros')
          .doc(widget.libroId)
          .collection('capitulos')
          .get();

      for (DocumentSnapshot capituloDoc in capitulosSnapshot.docs) {
        await capituloDoc.reference.delete();
      }
    } catch (e) {
      //
    }
  }

  Future<void> eliminarLibro() async {
    try {
      await eliminarCapitulos();
      await FirebaseFirestore.instance
          .collection('usuario')
          .doc(widget.usuarioId)
          .collection('libros')
          .doc(widget.libroId)
          .delete();

      regresaConMensaje('¡El libro ha sido eliminado exitosamente!');
    } catch (e) {
      mostrarSnackBar(context, 'Ha ocurrido un error. Intentalo mas tarde.');
    }
  }

  void regresaConMensaje(mensaje) {
    Navigator.pop(context, mensaje);
  }

  void mostrarSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(30.0),
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
    final imagenString = libro?.get('nombre_imagen') ?? 'libro.jpg';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF304E5D),
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              onPressed: () {
                eliminarLibro();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
              tooltip: 'Eliminar libro',
            ),
          ],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
            top: true,
            child: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: Column(children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          color: const Color.fromRGBO(176, 199, 189, 1),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 10, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ('assets/img/$imagenString'),
                                      width: 215,
                                      height: 315,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 15, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Text(
                                        (libro?.get('titulo') ?? 'Cargando...'),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: RichText(
                                      text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Autor: ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ((libro?.get('autor') ??
                                                  'Cargando...')),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          )),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: RichText(
                                      text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Género: ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: (libro?.get('genero') ??
                                                  'Cargando...'),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          )),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 5, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: RichText(
                                      text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Editorial: ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: (libro?.get('editorial') ??
                                                  'Cargando...'),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          )),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 20, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: RichText(
                                      text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Descripción corta:\n',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                            ),
                                            TextSpan(
                                              text: (libro?.get(
                                                      'descripcion_corta') ??
                                                  'Cargando...'),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          )),
                                      textAlign: TextAlign.start,
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 30, 0, 0),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              navegaAEditarFicha(context);
                                            },
                                            style: const ButtonStyle(
                                                textStyle:
                                                    MaterialStatePropertyAll(
                                                        TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Color(0xFF304E5D)),
                                                padding:
                                                    MaterialStatePropertyAll(
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(20, 10,
                                                                20, 10))),
                                            child: const Text('Editar ficha')),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color.fromRGBO(176, 199, 189, 1),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 10, 10, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            navegaAAgregarCapitulo(context);
                                          },
                                          style: const ButtonStyle(
                                              textStyle:
                                                  MaterialStatePropertyAll(
                                                      TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xFF304E5D)),
                                              padding: MaterialStatePropertyAll(
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          20, 10, 20, 10))),
                                          child:
                                              const Text('Agregar capítulo')),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.70,
                                  decoration: const BoxDecoration(),
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: capitulos?.length ?? 0,
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      height: 20.0,
                                      thickness: 3.0,
                                      color: Color.fromARGB(255, 78, 112, 129),
                                    ),
                                    itemBuilder: (context, index) {
                                      final capitulo = capitulos![index];
                                      final capituloId = capitulo.id;
                                      final nombreCapitulo =
                                          capitulo['nombre_capitulo'];
                                      //final redaccionCapitulo = capitulo['redaccion'];

                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF304E5D),
                                                    width: 5,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    eliminarCapitulo(
                                                        capituloId);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete_sweep_rounded,
                                                    color: Colors.red,
                                                    size: 45,
                                                  ),
                                                  tooltip: 'Eliminar capítulo',
                                                ),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.74,
                                                  height: 80,
                                                  alignment: Alignment.center,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xFF304E5D),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .all(5.0),
                                                    child: Text(
                                                      (nombreCapitulo),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                  ))
                                            ]),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: const Color.fromARGB(255, 225, 217, 206),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 15, 10, 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(),
                                    child: Text(
                                        (libro?.get('titulo') ?? 'Cargando...'),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Poppins',
                                          fontSize: 30,
                                          fontWeight: FontWeight.w800,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.70,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.elliptical(15, 15)),
                                          color:
                                              Color.fromRGBO(235, 239, 240, 1)),
                                      child: ListView.separated(
                                        padding: const EdgeInsets.all(5.0),
                                        //shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: capitulos?.length ?? 0,
                                        separatorBuilder: (context, index) =>
                                            const Divider(
                                          height: 20.0,
                                          thickness: 3.0,
                                          color: Color.fromARGB(
                                              255, 182, 182, 182),
                                        ),
                                        itemBuilder: (context, index) {
                                          final capitulo = capitulos![index];
                                          final nombreCapitulo =
                                              capitulo['nombre_capitulo'];
                                          final redaccionCapitulo =
                                              capitulo['redaccion'];

                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: const BoxDecoration(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Text(
                                                      (nombreCapitulo ??
                                                          'Cargando...'),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 23,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Text(
                                                      (redaccionCapitulo ??
                                                          'Cargando...'),
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment(0, 0),
                    child: TabBar(
                      labelColor: Color(0xFF304E5D),
                      labelStyle: TextStyle(fontSize: 14.0),
                      indicatorColor: Color(0xFF304E5D),
                      tabs: [
                        Tab(
                          text: 'Ficha técnica',
                          icon: Icon(
                            Icons.book,
                          ),
                        ),
                        Tab(
                          text: 'Capítulos',
                          icon: Icon(
                            Icons.menu_book,
                          ),
                        ),
                        Tab(
                          text: 'Vista previa',
                          icon: Icon(
                            Icons.preview,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}
