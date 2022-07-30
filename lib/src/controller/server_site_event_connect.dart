import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;


class ServerSiteEventConnect {
  final StreamController<String> streamController;

  ServerSiteEventConnect._internal(this.streamController);

  factory ServerSiteEventConnect.connect({
    required String uri,
    required bool closeOnError,
  }) {
    final streamController = StreamController<String>();
    try {
      http.Client client = http.Client();

      var request =
      http.Request("GET", Uri.parse(uri));
      request.headers["Cache-Control"] = "no-cache";
      request.headers["Accept"] = "text/event-stream";

      Future<http.StreamedResponse>? response = client.send(request);

      response.asStream().listen((response) {
        response.stream.listen((data) async {
          final parsedData = utf8.decode(data);
          streamController.add(parsedData);
        },
          cancelOnError: closeOnError,
        );
      },
          cancelOnError: true
      );
    } catch(e){
      log(e.toString());
    }

    return ServerSiteEventConnect._internal(streamController);
  }
}