import 'package:crud_flutter/controller/costumer_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = CostumersController();
  String email = '';
  String password = '';
  bool isTinder = false;

  Widget _body() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/images/logo-generic.png'),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            email = text;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text(
                            "Email",
                            style: TextStyle(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          errorText: email.isEmpty || email.contains("@")
                              ? null
                              : "Insira um email válido",
                          filled: true,
                          fillColor: const Color.fromARGB(144, 255, 255, 255),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            password = text;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          label: Text(
                            "Password",
                            style: TextStyle(color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          errorText: password.isEmpty || password.length >= 5
                              ? null
                              : "A senha deve ter pelo menos 5 caracteres",
                          filled: true,
                          fillColor: const Color.fromARGB(144, 255, 255, 255),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        final user = await _controller.login(email, password);
                        if (email == 'admin@email.com' &&
                            password == 'admin123') {
                          Navigator.of(context).pushReplacementNamed('/home');
                          return;
                        }
                        if (user != null) {
                          Navigator.of(context).pushReplacementNamed(
                            '/costumer-home',
                            arguments: user,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Email ou senha inválidos!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: const Color.fromARGB(
                              255,
                              211,
                              26,
                              26,
                            ),
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 194, 220, 255),
          ),
          _body(),
        ],
      ),
    );
  }
}
