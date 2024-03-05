import 'package:flutter/material.dart';
import 'login_page.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Token: ${data["token"]}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'User ID: ${data["userData"]["userId"]}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Username: ${data["userData"]["username"]}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Client ID: ${data["userData"]["client"]["id"]}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Created At: ${data["userData"]["client"]["createdAt"]}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Updated At: ${data["userData"]["client"]["updatedAt"]}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
