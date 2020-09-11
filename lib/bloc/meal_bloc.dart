import 'dart:async';

import 'package:food_manager_v2/models/price_list.dart';

class MealBloc {
  final stateStreamController = StreamController<PriceList>();

  StreamSink<PriceList> get choiceSink => stateStreamController.sink;

  Stream<PriceList> get choiceStream => stateStreamController.stream;
}
