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

  Future<dynamic> post(String url, String token, Map<String, String> body) async{
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

  Future<dynamic> delete(String url, String token, String id) async{
    var response = await http.delete(
      Uri.parse(_baseUrl + url + "$id"),
      headers: {'x-access-token': 'Bearer ' + token,}
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> patch(String url, String token, String id, Map<String, String> body) async{
    var response = await http.patch(
      Uri.parse(_baseUrl + url + "$id"),
      headers: {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        'x-access-token': 'Bearer ' + token,
      },
      body: json.encode(body)
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  Future<dynamic> login(String url, Map body) async{
    var response = await http.post(
      Uri.parse(_baseUrl + url),
      headers: {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      },
      body: json.encode(body)
    );
    var responseJson = _responseStatus(response);
    return responseJson;
  }

  dynamic _responseStatus(http.Response response){
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        return null;
      case 401:
        return null;
      case 403:
        return null;
      case 500:
        return null;
      default:
        return null;
    }
  }
}