import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getUsdPrice(String nameCoin) async {
  try {
    var url = "https://api.coingecko.com/api/v3/coins/" + nameCoin;
    var res = await http.get(url);
    var json = jsonDecode(res.body);
    var usd = json['market_data']['current_price']['usd'].toString();
    return double.parse(usd);
  } catch (e) {
    print(e.toString());
  }
}