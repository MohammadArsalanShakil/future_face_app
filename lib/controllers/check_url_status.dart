import 'package:http/http.dart' as http;

Future<bool> checkURL(String url) async {
  try {
    final response = await http.head(Uri.parse(url));

    if (response.statusCode == 200) return true;
  } catch (e) {}
  return false;
}
