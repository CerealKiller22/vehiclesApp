import 'dart:convert';

import 'package:vehicles_app/models/procedure.dart';
import 'package:vehicles_app/models/response.dart';
import "package:http/http.dart" as http;

import 'constans.dart';

class ApiHelper {
  static Future<Response> getProcedures(String token) async {
    var url = Uri.parse('${Constans.apiUrl}/api/Procedures');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization' : 'bearer ${token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSucces: false, Message: body);
    }

    List<Procedure> list = [];

    var decodeJson = jsonDecode(body);
    if(decodeJson != null){
      for (var item in decodeJson) {
        list.add(Procedure.fromJson(item));
      }
    }

    return Response(isSucces: true, result: list);
  }


  static Future<Response> put(String controller, String id, Map<String, dynamic> request, String token) async {
    var url = Uri.parse('${Constans.apiUrl}$controller$id');
    var response = await http.put(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization' : 'bearer ${token}',
      },
      body: jsonEncode(request),
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSucces: false, Message: response.body);
    }

    return Response(isSucces: true);
  }

  static Future<Response> post(String controller, Map<String, dynamic> request, String token) async {
    var url = Uri.parse('${Constans.apiUrl}$controller');
    var response = await http.post(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization' : 'bearer ${token}',
      },
      body: jsonEncode(request),
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSucces: false, Message: response.body);
    }

    return Response(isSucces: true);
  }

  static Future<Response> delete(String controller, String id, String token) async {
    var url = Uri.parse('${Constans.apiUrl}$controller$id');
    var response = await http.delete(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization' : 'bearer ${token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSucces: false, Message: response.body);
    }

    return Response(isSucces: true);
  }
}