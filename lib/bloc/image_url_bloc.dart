import 'dart:async';

import 'package:rxdart/rxdart.dart';

class ImageUrlBloc{
  final urlStreamController = BehaviorSubject<String>();

  StreamSink<String> get urlSink => urlStreamController.sink;

  Stream<String> get urlStream => urlStreamController.stream;

  imageUpload(String url){
    urlStreamController.sink.add(url);
  }

  void dispose() {
    urlStreamController.close();
  }
}