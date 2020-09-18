import 'dart:async';
import 'package:food_manager_v2/models/price_list.dart';

// This BLoC manages type of meal, price, and Meal Name and provides to its listener.

class MealBloc {
  final stateStreamController = StreamController<PriceList>();

  StreamSink<PriceList> get choiceSink => stateStreamController.sink;

  Stream<PriceList> get choiceStream => stateStreamController.stream;

  void dispose() {
    stateStreamController.close();
  }
}
