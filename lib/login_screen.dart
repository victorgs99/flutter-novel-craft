import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _unfocusNode = FocusNode();

  void iniciarSesion(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      mostrarSnackBar(context, 'Debes de llenar todos los campos');
      return;
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> usuarioRegistrado =
        await validarUsuario(username, password);

    if (usuarioRegistrado.isNotEmpty) {
      _completeLogin(usuarioRegistrado.first.id);
    } else {
      // ignore: use_build_context_synchronously
      mostrarSnackBar(context, 'Usuario no registrado');
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> validarUsuario(
      String username, String password) async {
    // Obtén una referencia a la colección "usuarios" en Firestore
    final docUsuarios = FirebaseFirestore.instance.collection('usuario');

    // Realiza la consulta para verificar si existe un documento con el nombre de usuario y contraseña proporcionados
    final querySnapshot = await docUsuarios
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .limit(1)
        .get();

    // Si se encuentra un documento, el usuario está registrado
    return querySnapshot.docs;
  }

  void navegaARegistro() async {
    final mensaje = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );

    if (mensaje != null) {
      // ignore: use_build_context_synchronously
      mostrarSnackBar(context, mensaje);
    }
  }

  void mostrarSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _completeLogin(String idUsuario) {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => HomeScreen(usuarioId: idUsuario),
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
          backgroundColor: const Color(0xFF304E5D),
          floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    navegaARegistro();
                  },
                  backgroundColor: Colors.white,
                  elevation: 8,
                  label: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: '¿Sin cuenta?\n',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            )),
                        TextSpan(
                          text: '¡Registrate ahora!',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF90DEAA), Color(0xFF304E5D)],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1)),
                  ),
                  child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(30, 30, 30, 30),
                      child: Image.asset(
                        'assets/img/logo-biblioteca.png',
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1,
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 513,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                        child: Text(
                          'Inicio de sesión',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFE6E9EE),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.35,
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              30, 30, 30, 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Usuario',
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
                              ),
                              Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 15.0),
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Contraseña',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        color: Color(0xFF304E5D),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 65, 170, 100),
                                      )),
                                    ),
                                    cursorColor:
                                        const Color.fromARGB(255, 65, 170, 100),
                                  )),
                              Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 30.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        iniciarSesion(context);
                                      },
                                      style: const ButtonStyle(
                                          textStyle: MaterialStatePropertyAll(
                                              TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold)),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Color(0xFF304E5D)),
                                          padding: MaterialStatePropertyAll(
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 10, 20, 10))),
                                      child: const Text('Ingresar'))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          )),
    );
  }
}
