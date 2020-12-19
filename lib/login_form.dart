import 'package:flutter/material.dart';

class LoginFormState {
  const LoginFormState({this.email, this.password});

  final String email;
  final String password;
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key key, this.state}) : super(key: key);

  final LoginFormState state;

  @override
  Widget build(BuildContext context) {
    debugPrint('LoginForm built...just one time!');

    final _emailKey = GlobalKey<FormFieldState<String>>();
    final _passwordKey = GlobalKey<FormFieldState<String>>();
    final _formKey = GlobalKey<FormState>();

    void _onSubmit() {
      if (_formKey.currentState.validate()) {
        final email = _emailKey.currentState.value;
        final password = _passwordKey.currentState.value;
        Navigator.of(context).pop(
          LoginFormState(
            email: email,
            password: password,
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: _emailKey,
              initialValue: state.email,
              autofocus: true,
              autocorrect: true,
              autofillHints: [AutofillHints.name],
              validator: (value) => (value.isEmpty) ? 'メールアドレスが必要です' : null,
              onFieldSubmitted: (_) => _onSubmit(),
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              key: _passwordKey,
              initialValue: state.password,
              autocorrect: true,
              obscureText: true,
              autofillHints: [AutofillHints.password],
              validator: (value) => (value.isEmpty) ? 'パスワードが空です' : null,
              onFieldSubmitted: (_) => _onSubmit(),
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.check),
              label: Text('SignIn'),
              onPressed: _onSubmit,
            )
          ],
        ),
      ),
    );
  }
}
