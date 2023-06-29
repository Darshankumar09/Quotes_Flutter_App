import 'package:quotes_app/models/quotes_model.dart';

class CategoryModel {
  int id;
  String categoryName;

  // String image;
  List<QuoteModel> quotes;

  CategoryModel({
    required this.id,
    required this.categoryName,
    // required this.image,
    required this.quotes,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        id: data["category-id"],
        categoryName: data["quotes-category"],
        // image: data["category-image"],
        quotes: List<QuoteModel>.from(
          data["quotes"].map(
            (quote) => QuoteModel.fromMap(quote),
          ),
        ),
      );
}
