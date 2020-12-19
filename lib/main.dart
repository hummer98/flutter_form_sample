import 'package:flutter/material.dart';

import 'login_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormSample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopPage(),
    );
  }
}

class TopPage extends StatelessWidget {
  final state = ValueNotifier(LoginFormState());

  @override
  Widget build(BuildContext context) {
    debugPrint('TopPage built...one time!');

    return Scaffold(
      appBar: AppBar(title: const Text('LoginForm Demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RaisedButton(
              child: Text('showDialog'),
              onPressed: () async {
                final result = await _showPage(context);
                if (result != null) state.value = result;
              },
            ),
            RaisedButton(
              child: Text('Push Page'),
              onPressed: () async {
                final result = await _pushPage(context);
                if (result != null) state.value = result;
              },
            ),
            ValueListenableBuilder(
              valueListenable: state,
              builder: (_, value, __) {
                return Text(
                    'email: ${state.value.email}\npassword: ${state.value.password}');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<LoginFormState> _showPage(BuildContext context) {
    return showDialog<LoginFormState>(
      context: context,
      builder: (_) => Dialog(
        child: LoginForm(state: LoginFormState()),
      ),
    );
  }

  Future<LoginFormState> _pushPage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text('LoginForm')),
          body: LoginForm(state: state.value),
        ),
      ),
    );
  }
}
