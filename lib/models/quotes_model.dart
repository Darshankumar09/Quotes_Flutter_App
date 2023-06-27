class QuotesModel {
  String category;
  List<Quote> quotes;

  QuotesModel({
    required this.category,
    required this.quotes,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
        category: json["category"],
        quotes: List<Quote>.from(json["quotes"].map((x) => Quote.fromJson(x))),
      );
}

class Quote {
  String quote;
  String author;

  Quote({
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
        quote: json["quote"],
        author: json["author"],
      );
}
