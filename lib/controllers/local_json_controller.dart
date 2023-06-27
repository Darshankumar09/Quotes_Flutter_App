import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_app/models/local_json_model.dart';
import 'package:quotes_app/models/quotes_model.dart';

class LocalJsonController extends GetxController {
  LocalJsonModel localJsonModel = LocalJsonModel(jsonData: "", quotes: []);

  LocalJsonDataLoad() async {
    String jsonPath = "lib/utils/resources/json/quotes.json";
    localJsonModel.jsonData = await rootBundle.loadString(jsonPath);

    List decodedList = jsonDecode(localJsonModel.jsonData);

    localJsonModel.quotes =
        decodedList.map((e) => QuotesModel.fromJson(e)).toList();

    update();
  }
}
