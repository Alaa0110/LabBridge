import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:labbridge/core/class/status_request.dart';
import 'check_internet.dart';

class Crud {
  /// Generic POST request method
  Future<Either<StatusRequest, Map>> postData(
      String linkUrl, Map data, Map<String, String> header) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkUrl),
          body: jsonEncode(data),
          headers: header,
        );
        print('POST Response: ${response.statusCode}, Body: ${response.body}'); // Debug logging

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print('POST Error: $e'); // Error logging
      return const Left(StatusRequest.serverFailure);
    }
  }

  /// Generic GET request method
  Future<Either<StatusRequest, dynamic>> getData(
      String linkUrl, Map<String, String> header) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(
          Uri.parse(linkUrl),
          headers: header,
        );
        print('GET Response: ${response.statusCode}, Body: ${response.body}'); // Debug logging

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print('GET Error: $e'); // Error logging
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> putData(
      String linkUrl, dynamic body, Map<String, String> header) async {
    try {
      if (await checkInternet()) {
        var response = await http.put(
          Uri.parse(linkUrl),
          headers: header,
          body: jsonEncode(body),
        );
        print('PUT Response: ${response.statusCode}, Body: ${response.body}'); // Debug logging

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print('PUT Error: $e'); // Error logging
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> deleteData(
      String linkUrl, Map<String, String> header) async {
    try {
      if (await checkInternet()) {
        var response = await http.delete(
          Uri.parse(linkUrl),
          headers: header,
        );
        print('DELETE Response: ${response.statusCode}, Body: ${response.body}'); // Debug logging

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print('DELETE Error: $e'); // Error logging
      return const Left(StatusRequest.serverFailure);
    }
  }
  Future<Either<StatusRequest, Map>> patchData(
      String linkUrl, dynamic body, Map<String, String> header) async {
    try {
      if (await checkInternet()) {
        var response = await http.patch(
          Uri.parse(linkUrl),
          headers: header,
          body: jsonEncode(body),
        );
        print('PATCH Response: ${response.statusCode}, Body: ${response.body}'); // Debug logging

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print('PATCH Error: $e'); // Error logging
      return const Left(StatusRequest.serverFailure);
    }
  }

}
