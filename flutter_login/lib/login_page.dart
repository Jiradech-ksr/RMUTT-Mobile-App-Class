import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (setting) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://www.rmutt.ac.th/wp-content/uploads/2023/01/20210202-logo-RMUTT-News-1024x341.png',
                        width: 400,
                        height: 150,
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'username',
                        ),
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'please enter username';
                          }
                          return null;
                        },
                      ),TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'password',
                        ),
                        validator: (value){
                          if (value!.isEmpty) {
                            return 'please enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24,),
                      ElevatedButton(onPressed: (){
                        if (_formKey.currentState!.validate()) {
                          
                        }
                      }, child: const Text('Login'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
