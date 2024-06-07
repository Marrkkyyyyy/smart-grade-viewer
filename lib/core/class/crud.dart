import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'dart:async';
import 'package:smart_grade_viewer/core/class/status_request.dart';
import 'package:smart_grade_viewer/core/functions/check_internet.dart';

class Crud {
  http.Client client = http.Client();

  Future<Either<StatusRequest, Map>> postData(String linkUrl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await client.post(Uri.parse(linkUrl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  Future<Either<StatusRequest, Map>> postImageData(
      String linkurl, Map<String, dynamic> parameters) async {
    try {
      if (await checkInternet()) {
        Uri uri = Uri.parse(linkurl);
        var request = http.MultipartRequest('POST', uri);

        if (parameters.containsKey('image') &&
            parameters['image'] is List<File?>) {
          List<File?> imageFiles = parameters['image'];

          for (int i = 0; i < imageFiles.length; i++) {
            final imageFile = imageFiles[i];
            if (imageFile != null) {
              request.files.add(
                  await http.MultipartFile.fromPath('image[]', imageFile.path));
            }
          }

          parameters.remove('image');

          parameters.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        } else if (parameters.containsKey('image') &&
            parameters['image'] is File) {
          File? imageFiles = parameters['image'];
          request.files.add(
              await http.MultipartFile.fromPath('image', imageFiles!.path));
          parameters.remove('image');
          parameters.forEach((key, value) {
            request.fields[key] = value.toString();
          });
        }

        var response = await client.send(request);
        var responseString = await response.stream.bytesToString();
        final responsebody = json.decode(responseString);

        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } else {
        return const Left(StatusRequest.offlinefailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverfailure);
    }
  }

  void cancelRequest() {
    client.close();
  }
}
