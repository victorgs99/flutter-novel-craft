//import 'package:bloc_de_ideas/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _unfocusNode = FocusNode();

  Future registrar() async {
    final docUser = FirebaseFirestore.instance.collection('usuario').doc();
    final json = {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text
    };
    await docUser.set(json);

    // ignore: use_build_context_synchronously
    Navigator.pop(context,
        '¡El usuario ${usernameController.text} ha sido registrado con éxito!');
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
                          'Registro de usuario',
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
                        height: MediaQuery.of(context).size.height * 0.42,
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
                                  labelText: 'Nombre de usuario',
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
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Email',
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
                                        registrar();
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
                                      child: const Text('Registrar'))),
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
