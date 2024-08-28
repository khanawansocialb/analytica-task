import 'dart:convert';

import 'package:http/http.dart' as http;

class QuoteService {

  static Future<String> getQuote() async {
    var res = await http.get(Uri.parse(
        "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"));
    return jsonDecode(res.body)["quoteText"];
  }
}
