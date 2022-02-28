// ignore: file_names
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;

class ApiService{
  final String _baseUrl = "http://10.0.2.2:9800/api/v1/";

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
    };

  Future<dynamic> getAll(String url, String token) async{
    var response = await http.get(
      Uri.parse(_baseUrl + url), 
      headers: {'x-access-token': 'Bearer ' + token},
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> getOne(String url, String, token, String id) async{
    var response = await http.get(
      Uri.parse(_baseUrl + url + "$id"),
      headers: {'x-access-token': 'Bearer ' + token},
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> get(String url) async{
    var response = await http.get(
      Uri.parse(_baseUrl + url),
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> post(String url, String token, Map body) async{
    var response = await http.post(
      Uri.parse(_baseUrl + url),
      headers: {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        'x-access-token': 'Bearer ' + token,
      },
      body: json.encode(body),
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> postWithoutToken(String url, body) async{
    var response = await http.post(
      Uri.parse(_baseUrl + url),
      headers: {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      },
      body: json.encode(body),
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> delete(String url, String id, {String? token}) async{
    var response = await http.delete(
      Uri.parse(_baseUrl + url + "$id"),
      headers: {/*'x-access-token': 'Bearer ' + token,*/'Content-type': 'application/json; charset=utf-8',}
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> patch(String url, String id, Map body, {String? token}) async{
    var response = await http.patch(
      Uri.parse(_baseUrl + url + "$id"),
      headers: {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        /*'x-access-token': 'Bearer ' + token,*/
      },
      body: json.encode(body)
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> postMultipart(String url, Map body, {String? token}) async{
    var request = await http.MultipartRequest("POST", Uri.parse(_baseUrl + url));

    request.headers.addAll({"Content-Type": "multipart/form-data"});

    request.fields["bi"] = body["bi"];
    request.fields["fullName"] = body["fullName"];
    request.fields["birthdate"] = body["birthdate"];
    request.fields["gender"] = body["gender"];
    request.fields["email"] = body["email"];
    request.fields["telephone"] = body["telephone"];
    request.fields["qualificationId"] = body["qualificationId"];
    request.fields["regime"] = body["regime"];
    request.fields["ipilDate"] = body["ipilDate"];
    request.fields["educationDate"] = body["educationDate"];
    request.fields["category"] = body["category"];

    request.files.add(await http.MultipartFile.fromPath('avatar', body["avatar"]));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    
    if (response.statusCode == 200){
      return responseData;
    } 
  }

  dynamic _responseStatus(response){
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 401:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 403:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 500:
        var responseJson = json.decode(response.body);
        return responseJson;
      default:
        var responseJson = json.decode(response.body);
        return responseJson;
    }
  }
}