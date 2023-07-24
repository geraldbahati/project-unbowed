import 'package:http/http.dart' as http;
import 'package:unbowed_flutter/data/services/shared_services.dart';

import '../config/config.dart';

class ApiService<T> {
  final String url;
  final dynamic body;
  T Function(http.Response response) parse;

  ApiService({
    required this.url,
    this.body,
    required this.parse,
  });
}

class Api {
  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;

      case 201:
        return response;

      case 204:
        return response;

      case 400:
        throw Exception("Bad Request");
      case 401:
        throw Exception("Unauthorized");
      case 403:
        throw Exception("Forbidden");
      case 404:
        throw Exception("Not Found");
      case 500:
        throw Exception("Internal Server Error");
      default:
        throw Exception("Error");
    }
  }

  Future<T> load<T>(ApiService<T> service) async {
    var loginDetails = await SharedService().getLoginDetails();

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${loginDetails?.tokens.access}",
    };

    Uri url = Uri.http(Config.domain, service.url);

    http.Response response = await http.get(
      url,
      headers: requestHeaders,
    );

    return service.parse(_response(response));
  }

  Future<T> post<T>(ApiService<T> service) async {
    var loginDetails = await SharedService().getLoginDetails();

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${loginDetails?.tokens.access}",
    };

    Uri url = Uri.http(Config.domain, service.url);

    http.Response response = await http.post(
      url,
      headers: requestHeaders,
      body: service.body,
    );

    return service.parse(_response(response));
  }

  Future<T> put<T>(ApiService<T> service) async {
    var loginDetails = await SharedService().getLoginDetails();

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${loginDetails?.tokens.access}",
    };

    Uri url = Uri.http(Config.domain, service.url);

    http.Response response = await http.put(
      url,
      headers: requestHeaders,
      body: service.body,
    );

    return service.parse(_response(response));
  }

  Future<T> delete<T>(ApiService<T> service) async {
    var loginDetails = await SharedService().getLoginDetails();

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${loginDetails?.tokens.access}",
    };

    Uri url = Uri.http(Config.domain, service.url);

    http.Response response = await http.delete(
      url,
      headers: requestHeaders,
    );

    return service.parse(_response(response));
  }

  Future<T> patch<T>(ApiService<T> service) async {
    var loginDetails = await SharedService().getLoginDetails();

    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${loginDetails?.tokens.access}",
    };

    Uri url = Uri.http(Config.domain, service.url);

    http.Response response = await http.patch(
      url,
      headers: requestHeaders,
      body: service.body,
    );

    return service.parse(_response(response));
  }

  Future<T> postWithoutToken<T>(ApiService<T> service) async {
    Map<String, String> requestHeaders = {
      "Content-Type": "application/json",
    };

    Uri url = Uri.http(Config.domain, service.url);

    print(service.body);
    print(url);

    http.Response response = await http.post(
      url,
      headers: requestHeaders,
      body: service.body,
    );

    print("here is the response: ${response.statusCode}");

    return service.parse(_response(response));
  }
}
