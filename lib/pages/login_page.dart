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
  bool _rememberPassword = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  Future<void> _loadRememberedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('remembered_username') ?? '';
      _passwordController.text = prefs.getString('remembered_password') ?? '';
      _rememberUsername = _usernameController.text.isNotEmpty;
      _rememberPassword = _passwordController.text.isNotEmpty;
    });
  }

  Future<void> _saveRememberedCredentials(
      String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('remembered_username', username);
    await prefs.setString('remembered_password', password);
  }

  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final Map<String, dynamic> data =
          await ApiService.login(username, password);

      if (data.containsKey('token')) {
        if (_rememberUsername) {
          await _saveRememberedCredentials(
              username, _rememberPassword ? password : '');
        }

        // Show loading indicator for 300 milliseconds
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
              child: RefreshProgressIndicator(
                color: Colors.orange[700],
              ),
            );
          },
        );

        await Future.delayed(Duration(milliseconds: 1000));

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
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.orange),
                  ),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 150),
                Container(
                    child: Icon(
                  Icons.login_outlined,
                  size: 160,
                  color: Colors.orange[700],
                )),
                SizedBox(height: 25),
                Container(
                  child: Text(
                    "Please Sign In",
                    style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _rememberPassword,
                      onChanged: (value) {
                        setState(() {
                          _rememberPassword = value!;
                        });
                      },
                      activeColor: Colors.orange,
                    ),
                    Text('Remember Password'),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange[700],
                    elevation:
                        10, // Adjust the value to control the shadow intensity
                    shadowColor: Colors
                        .grey, // You can customize the shadow color if needed
                  ),
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
      ),
    );
  }
}
