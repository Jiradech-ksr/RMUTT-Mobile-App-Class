import 'package:flutter/material.dart';

void main() {
  runApp(const App803());
}

class App803 extends StatelessWidget {
  const App803({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var varEmail = TextEditingController();
  var varPWD = TextEditingController();
  var varName = TextEditingController();
  String varString = '';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('TextField')),
    body: Center(
      child: SizedBox(
        width: 350,
        child: Column(
          children: [
            const SizedBox(height: 30),
            //const Text('email\t: '),
            textFieldEmail(),
            const SizedBox(height: 30),
            //const Text('name\t: '),
            textFieldName(),
            const SizedBox(height: 30),
            //const Text('password\t: '),
            textFieldPWD(),
            const SizedBox(height: 30),
            //const Text('String\t: '),
            Text('$varString'),
          ],
        ),
      ),
    ),
  );
  OutlineInputBorder outlineInputBorder() => const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2),
  );
  TextStyle textStyle() => const TextStyle(
    color: Colors.indigo,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  Widget textFieldEmail() => TextField(
    controller: varEmail,
    decoration: InputDecoration(
      border: outlineInputBorder(),
      hintText: 'Enter your email',
    ),
    keyboardType: TextInputType.emailAddress,
    style: textStyle(),
    onChanged: (_) => updateText(),
    onSubmitted: null,
  );

  void updateText() => setState(() {
    varString = 'Email: ${varEmail.value.text}\n';
    varString += 'password : ${varPWD.value.text}\n';
    varString += 'Name : ${varName.value.text}\n';
  });

  Widget textFieldPWD() => TextField(
    controller: varPWD,
    decoration: InputDecoration(
      border: outlineInputBorder(),
      hintText: 'password',
    ),
    obscureText: true,
    keyboardType: TextInputType.text,
    style: textStyle(),
    onChanged: (text) => updateText(),
    onSubmitted: null,
  );
  Widget textFieldName() => TextField(
    controller: varName,
    decoration: InputDecoration(
      border: outlineInputBorder(),
      hintText: 'password',
    ),
    keyboardType: TextInputType.text,
    style: textStyle(),
    onChanged: (text) => updateText(),
    onSubmitted: null,
  );

}
