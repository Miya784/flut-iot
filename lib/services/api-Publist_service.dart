import 'package:http/http.dart' as http;

class apiPublist_service {
  static Future<http.Response> sendDataToServer(
      {required String switchData,
      required String token,
      required String clientIndex}) async {
    final String url =
        'https://node-emqx.burhan.cloud/client/publish'; // แทนที่ด้วย URL ของเซิร์ฟเวอร์ของคุณ

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // เพิ่ม Token ใน Header Authorization
        },
        body:
            '{"topic": "$clientIndex", "payload": {"data": "$switchData"}}', // สร้าง Body ของ API ตามที่ต้องการ
      );

      if (response.statusCode == 200) {
        print('Data sent successfully!');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
      return response;
    } catch (error) {
      print('Error: $error');
      return http.Response('Error: $error', 500);
    }
  }

  static getClientData({required String token}) {}
}
