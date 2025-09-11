import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future sing_up() async {
    String url = "http://127.0.0.1/login_php/register.php";
    final Response = await http.post(
      Uri.parse(url),
      body: {'name': name.text, 'email': email.text, 'password': pass.text},
    );
    print(Response.body);
    var data = json.decode(Response.body);
    if (data == "error") {
      Navigator.pushNamed(context, 'register');
    } else {
      Navigator.pushNamed(context, 'home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 4, 29),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.network(
                    'https://www.rmutt.ac.th/wp-content/uploads/2023/01/20210202-logo-RMUTT-News-1024x341.png',
                    width: 400,
                    height: 150,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please complete your data',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your name.";
                        }
                        return null;
                      },
                      controller: name,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Your E-Mail',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your e-mail.";
                        }
                        return null;
                      },
                      controller: email,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Create your Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your password.";
                        }
                        return null;
                      },
                      controller: pass,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-Type your Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please re-enter your password.";
                        } else if (value != pass.text) {
                          return 'password does not match.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: const Color(0xFF3F60A0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        //Navigator.pushNamed(context, 'home');
                        bool pass = formKey.currentState!.validate();
                        if (pass) {
                          sing_up();
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
