import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditFichaScreen extends StatefulWidget {
  const EditFichaScreen(
      {super.key, required this.libro, required this.usuarioId});

  //final String bookId;
  final DocumentSnapshot libro;
  final String usuarioId;

  @override
  State<EditFichaScreen> createState() => _EditFichaScreenState();
}

class _EditFichaScreenState extends State<EditFichaScreen> {
  late TextEditingController nameImgFileController =
      TextEditingController(text: widget.libro.get('nombre_imagen'));
  late TextEditingController titleController =
      TextEditingController(text: widget.libro.get('titulo'));
  late TextEditingController autorController =
      TextEditingController(text: widget.libro.get('autor'));
  late TextEditingController genreController =
      TextEditingController(text: widget.libro.get('genero'));
  late TextEditingController editorialController =
      TextEditingController(text: widget.libro.get('editorial'));
  late TextEditingController shortDescriptionController =
      TextEditingController(text: widget.libro.get('descripcion_corta'));

  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  Future<void> editarLibro() async {
    try {
      await FirebaseFirestore.instance
          .collection('usuario')
          .doc(widget.usuarioId)
          .collection('libros')
          .doc(widget.libro.id)
          .update({
        'nombre_imagen': nameImgFileController.text,
        'titulo': titleController.text,
        'autor': autorController.text,
        'genero': genreController.text,
        'editorial': editorialController.text,
        'descripcion_corta': shortDescriptionController.text,
      });

      regresaConMensaje('¡La ficha se ha actualizado correctamente!');
    } catch (error) {
      regresaConMensaje('¡Ha ocurrido un error! Intente nuevamente');
    }
  }

  void regresaConMensaje(mensaje) {
    Navigator.pop(context, mensaje);
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Scaffold(
            //backgroundColor: const Color(0xFF304E5D),
            appBar: AppBar(
              backgroundColor: const Color(0xFF304E5D),
              automaticallyImplyLeading: true,
              title: const Text('Editando ficha de libro'),
              centerTitle: false,
              elevation: 2,
            ),
            body: SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  //height: MediaQuery.of(context).size.height * 0.42,
                  decoration: BoxDecoration(
                      color: const Color(0xFFE6E9EE),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: nameImgFileController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText:
                                'Nombre del archivo de portada del libro',
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xFF304E5D),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromARGB(255, 65, 170, 100),
                            )),
                          ),
                          cursorColor: const Color.fromARGB(255, 65, 170, 100),
                        ),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Título del libro',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              controller: autorController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Nombre del autor',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              controller: genreController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Género del libro',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              controller: editorialController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Nombre de la editorial',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 30.0),
                            child: TextFormField(
                              controller: shortDescriptionController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Descripción breve sobre el libro',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 50.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      editarLibro();
                                    },
                                    style: const ButtonStyle(
                                        textStyle: MaterialStatePropertyAll(
                                            TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold)),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xFF304E5D)),
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsetsDirectional.fromSTEB(
                                                20, 10, 20, 10))),
                                    child: const Text('Actualizar')),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )))));
  }
}

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key, required this.idUsuario});

  final String idUsuario;

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final nameImgFileController = TextEditingController();
  final titleController = TextEditingController();
  final autorController = TextEditingController();
  final genreController = TextEditingController();
  final editorialController = TextEditingController();
  final shortDescriptionController = TextEditingController();

  final _unfocusNode = FocusNode();

  Future agregarLibro() async {
    if (titleController.text.isEmpty || autorController.text.isEmpty) {
      mostrarSnackBar(context,
          'Debes de llenar, por lo menos, los campos: título, autor, género y editorial');
      return;
    }

    final docUserRef =
        FirebaseFirestore.instance.collection('usuario').doc(widget.idUsuario);

    final nuevoLibro = {
      'nombre_imagen': nameImgFileController.text,
      'titulo': titleController.text,
      'autor': autorController.text,
      'genero': genreController.text,
      'editorial': editorialController.text,
      'descripcion_corta': shortDescriptionController.text,
    };

    final librosCollectionRef = docUserRef.collection('libros');
    await librosCollectionRef.add(nuevoLibro);

    regresaConMensaje('El libro "${titleController.text}" ha sido agregado!');
  }

  void regresaConMensaje(mensaje) {
    Navigator.pop(context, mensaje);
  }

  void mostrarSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 2),
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Scaffold(
            //backgroundColor: const Color(0xFF304E5D),
            appBar: AppBar(
              backgroundColor: const Color(0xFF304E5D),
              automaticallyImplyLeading: true,
              title: const Text('Agregando libro'),
              centerTitle: false,
              elevation: 2,
            ),
            body: SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  //height: MediaQuery.of(context).size.height * 0.42,
                  decoration: BoxDecoration(
                      color: const Color(0xFFE6E9EE),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: nameImgFileController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText:
                                'Nombre del archivo de portada del libro',
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xFF304E5D),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromARGB(255, 65, 170, 100),
                            )),
                          ),
                          cursorColor: const Color.fromARGB(255, 65, 170, 100),
                        ),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: titleController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Título del libro',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: autorController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Nombre del autor',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: genreController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Género del libro',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 15.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.words,
                              controller: editorialController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Nombre de la editorial',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 30.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 2,
                              controller: shortDescriptionController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Descripción breve sobre el libro',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 50.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      agregarLibro();
                                    },
                                    style: const ButtonStyle(
                                        textStyle: MaterialStatePropertyAll(
                                            TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold)),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xFF304E5D)),
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsetsDirectional.fromSTEB(
                                                20, 10, 20, 10))),
                                    child: const Text('Agregar')),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )))));
  }
}

class AddBookChapterScreen extends StatefulWidget {
  const AddBookChapterScreen(
      {super.key, required this.libroId, required this.usuarioId});

  final String libroId;
  final String usuarioId;

  @override
  State<AddBookChapterScreen> createState() => _AddBookChapterScreenState();
}

class _AddBookChapterScreenState extends State<AddBookChapterScreen> {
  final nameChapterController = TextEditingController();
  final chapterController = TextEditingController();

  final _unfocusNode = FocusNode();

  Future<void> agregarCapitulo() async {
    try {
      await FirebaseFirestore.instance
          .collection('usuario')
          .doc(widget.usuarioId)
          .collection('libros')
          .doc(widget.libroId)
          .collection('capitulos')
          .add({
        'nombre_capitulo': nameChapterController.text,
        'redaccion': chapterController.text,
      });

      regresaConMensaje('¡El capítulo ha sido agregado!');
    } catch (error) {
      regresaConMensaje('¡Ha ocurrido un error! Intente nuevamente');
    }
  }

  void regresaConMensaje(mensaje) {
    Navigator.pop(context, mensaje);
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Scaffold(
            //backgroundColor: const Color(0xFF304E5D),
            appBar: AppBar(
              backgroundColor: const Color(0xFF304E5D),
              automaticallyImplyLeading: true,
              title: const Text('Agregando libro'),
              centerTitle: false,
              elevation: 2,
            ),
            body: SingleChildScrollView(
                child: SafeArea(
                    child: Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1,
                  //height: MediaQuery.of(context).size.height * 0.42,
                  decoration: BoxDecoration(
                      color: const Color(0xFFE6E9EE),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: nameChapterController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Nombre del capítulo',
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xFF304E5D),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromARGB(255, 65, 170, 100),
                            )),
                          ),
                          cursorColor: const Color.fromARGB(255, 65, 170, 100),
                        ),
                        Padding(
                            padding:
                                const EdgeInsetsDirectional.only(top: 30.0),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              controller: chapterController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Redacción del capítulo',
                                labelStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Color(0xFF304E5D),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Color.fromARGB(255, 65, 170, 100),
                                )),
                              ),
                              cursorColor:
                                  const Color.fromARGB(255, 65, 170, 100),
                            )),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 50.0),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      agregarCapitulo();
                                    },
                                    style: const ButtonStyle(
                                        textStyle: MaterialStatePropertyAll(
                                            TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.bold)),
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xFF304E5D)),
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsetsDirectional.fromSTEB(
                                                20, 10, 20, 10))),
                                    child: const Text('Agregar')),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            )))));
  }
}
