import 'dart:async';

class UploadProgressBloC{
  final progressStreamController = StreamController<bool>.broadcast();


  void dispose() {
    progressStreamController.close();
  }
}