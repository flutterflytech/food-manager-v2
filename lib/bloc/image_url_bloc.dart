import 'dart:async';

class ImageUrlBloc{
  final urlStreamController = StreamController<String>();

  StreamSink<String> get urlSink => urlStreamController.sink;

  Stream<String> get urlStream => urlStreamController.stream;

  void dispose() {
    urlStreamController.close();
  }
}