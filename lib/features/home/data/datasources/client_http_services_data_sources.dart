import 'package:http/http.dart' as http;
// import 'package:movies_list/core/utils/api_strings/features/home/api_strings_remote.dart';

abstract class HttpService {
  Future<dynamic> get(String path, {dynamic data});
}

class HttpServiceImpl implements HttpService {
  final http.Client client;
  const HttpServiceImpl({required this.client});

  @override
  Future get(String path, {data}) {
    return client.get(Uri.parse(path));
  }
}
