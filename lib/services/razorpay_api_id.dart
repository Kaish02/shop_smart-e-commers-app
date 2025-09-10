import 'dart:convert';

import 'package:http/http.dart' as http;

class RazorpayApiId {
  static Future<String?> ApiRazorPayIdRequest(int amountInPaise) async {
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('rzp_test_RD1pZKGIvZI1eu:Retr0htQrxEqFRZAEtW9QuCk'))}';
    var requestBody = {
      "amount": amountInPaise,
      "currency": "INR",
      "receipt": "Receipt no. 1",
      "notes": {
        "notes_key_1": "Tea, Earl Grey, Hot",
        "notes_key_2": "Tea, Earl Grey… decaf."
      }
    };
    var request = await http.post(
        Uri.parse("https://api.razorpay.com/v1/orders"),
        body: jsonEncode(requestBody),
        headers: {
          "authorization": basicAuth,
          "Content-Type": "application/json"
        }
    );

    if (request.statusCode == 200) {
      var jsonBody = jsonDecode(request.body);
      var id = jsonBody["id"];
      return id;
    }
    return "";
  }
}
