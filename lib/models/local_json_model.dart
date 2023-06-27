import 'package:quotes_app/models/quotes_model.dart';

class LocalJsonModel {
  String jsonData;
  List<QuotesModel> quotes;

  LocalJsonModel({
    required this.jsonData,
    required this.quotes,
  });
}
