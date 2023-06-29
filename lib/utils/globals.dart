import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes_app/models/categories_database_model.dart';
import 'package:quotes_app/models/quotes_database_model.dart';

double height = Get.height;
double width = Get.width;

final getStorage = GetStorage();

late Future<List<CategoryDatabaseModel>> fetchAllCategory;

int? quoteId;
String? categoryName;
late Future<List<QuotesDatabaseModel>> allQuotes;
late Future<List<QuotesDatabaseModel>> quote;
