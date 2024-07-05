import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/auth_provider.dart';

//Login Page
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _usernameController.removeListener(_validateFields);
    _passwordController.removeListener(_validateFields);
    _usernameController.dispose();
    _passwordController.dispose();
    _isButtonEnabled.dispose();
    super.dispose();
  }

  void _validateFields() {
    _isButtonEnabled.value = _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<bool>(
          valueListenable: _isButtonEnabled,
          builder: (context, isEnabled, child) {
            return ElevatedButton(
              onPressed: isEnabled
                  ? () {
                      Provider.of<AuthProvider>(context, listen: false).login(
                        _usernameController.text,
                        _passwordController.text,
                      );
                    }
                  : null,
              child: const Text('Login'),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          //2 screen sizes, web and mobile
          if (constraints.maxWidth > 600) {
            // Web layout
            return Row(
              children: <Widget>[
                const SizedBox(
                  height: 200,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildLoginForm(),
                  ),
                ),
              ],
            );
          } else {
            // Mobile layout
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildLoginForm(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
