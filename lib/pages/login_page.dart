import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'home_page.dart';
import 'pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberUsername = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedUsername();
  }

  Future<void> _loadRememberedUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('remembered_username') ?? '';
      _rememberUsername = _usernameController.text.isNotEmpty;
    });
  }

  Future<void> _saveRememberedUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('remembered_username', username);
  }

  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final Map<String, dynamic> data =
          await ApiService.login(username, password);

      if (data.containsKey('token')) {
        // Save username if remember username is checked
        if (_rememberUsername) {
          await _saveRememberedUsername(username);
        }

        // Show loading indicator for 300 milliseconds
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        // Delay navigation by 500 milliseconds
        await Future.delayed(Duration(milliseconds: 500));

        // Dismiss loading dialog
        Navigator.of(context).pop();

        // Navigate to the home page with a replacement
        _navigateToHomePage(context, data);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Invalid username or password.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _navigateToHomePage(BuildContext context, Map<String, dynamic> data) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(data: data)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: Icon(
                Icons.login_outlined,
                size: 200,
                color: Colors.orange[700],
              )),
              SizedBox(height: 25),
              Container(
                child: Text(
                  "Please Sign In",
                  style: TextStyle(color: Colors.orange[800], fontSize: 20),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.orange[50],
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.orange)),
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.orange[50],
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.orange)),
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _rememberUsername,
                    onChanged: (value) {
                      setState(() {
                        _rememberUsername = value!;
                      });
                    },
                    activeColor: Colors.orange,
                  ),
                  Text('Remember Username'),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange[700]),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _login(context);
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              TextButton(
                style:
                    TextButton.styleFrom(foregroundColor: Colors.orange[700]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
