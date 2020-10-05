import 'dart:async';

class UploadProgressBloC{
  final progressStreamController = StreamController<bool>();


  void dispose() {
    progressStreamController.close();
  }
}