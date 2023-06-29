import 'package:path/path.dart';
import 'package:quotes_app/controllers/database_check_controller.dart';
import 'package:quotes_app/controllers/json_controller.dart';
import 'package:quotes_app/models/categories_database_model.dart';
import 'package:quotes_app/models/categories_model.dart';
import 'package:quotes_app/models/quotes_database_model.dart';
import 'package:quotes_app/utils/globals.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  Future<void> initDB() async {
    String dbLocation = await getDatabasesPath();

    String path = join(dbLocation, "Quotes.db");

    db = await openDatabase(path, version: 1, onCreate: (db, _) async {
      String query1 =
          "CREATE TABLE IF NOT EXISTS categories(category_id INTEGER, category_name TEXT NOT NULL);";
      String query2 =
          "CREATE TABLE IF NOT EXISTS quotes(quote_id INTEGER, quote_category TEXT NOT NULL, quote TEXT NOT NULL, author TEXT NOT NULL);";

      await db.execute(query1);
      await db.execute(query2);
    });
  }

  Future insertCategory() async {
    await initDB();
    JsonController jsonController = JsonController();

    List<CategoryModel> categories = await jsonController.localJsonDecode();

    for (int i = 0; i < categories.length; i++) {
      String query1 =
          "INSERT INTO categories(category_id, category_name) VALUES (? , ?);";
      List args1 = [
        categories[i].id,
        categories[i].categoryName,
      ];

      int res = await db!.rawInsert(query1, args1);
    }

    for (int i = 0; i < categories.length; i++) {
      for (int j = 0; j < categories[i].quotes.length; j++) {
        String query2 =
            "INSERT INTO quotes(quote_id, quote_category, quote, author) VALUES (? , ? , ? , ?);";

        List args2 = [
          categories[i].quotes[j].id,
          categories[i].quotes[j].category,
          categories[i].quotes[j].quote,
          categories[i].quotes[j].author,
        ];

        int res = await db!.rawInsert(query2, args2);
      }
    }
  }

  Future<List<CategoryDatabaseModel>> fetchAllCategory() async {
    await initDB();

    DataBaseCheckController dataBaseCheckController = DataBaseCheckController();

    if (getStorage.read("isTableInserted") != true) {
      await insertCategory();
      dataBaseCheckController.dataInserted();
    }

    String query = "SELECT * FROM categories;";

    List<Map<String, dynamic>> res = await db!.rawQuery(query);

    List<CategoryDatabaseModel> allCategories =
        res.map((e) => CategoryDatabaseModel.formMap(data: e)).toList();

    return allCategories;
  }

  Future<List<QuotesDatabaseModel>> fetchAllQuotes(
      {required String categoryName}) async {
    await initDB();

    String query = "SELECT * FROM quotes WHERE quote_category = ?;";
    List args = [categoryName];

    List<Map<String, dynamic>> res = await db!.rawQuery(query, args);

    List<QuotesDatabaseModel> allQuotes =
        res.map((e) => QuotesDatabaseModel.formMap(data: e)).toList();

    return allQuotes;
  }

  Future<List<QuotesDatabaseModel>> fetchQuote(
      {required int quoteId, required String categoryName}) async {
    await initDB();

    String query =
        "SELECT * FROM quotes WHERE quote_id = ? AND quote_category = ?;";
    List args = [quoteId, categoryName];

    List<Map<String, dynamic>> res = await db!.rawQuery(query, args);

    List<QuotesDatabaseModel> quote =
        res.map((e) => QuotesDatabaseModel.formMap(data: e)).toList();

    return quote;
  }
}
