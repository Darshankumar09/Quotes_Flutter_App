import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quotes_app/models/quotes_database_model.dart';
import 'package:quotes_app/utils/globals.dart';
import 'package:quotes_app/utils/helpers/dbHelper.dart';
import 'package:share_plus/share_plus.dart';

class QuoteDetailsPage extends StatefulWidget {
  const QuoteDetailsPage({super.key});

  @override
  State<QuoteDetailsPage> createState() => _QuoteDetailsPageState();
}

class _QuoteDetailsPageState extends State<QuoteDetailsPage> {
  @override
  void initState() {
    super.initState();

    quote = DBHelper.dbHelper
        .fetchQuote(quoteId: quoteId!, categoryName: categoryName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(height * 0.016),
        child: FutureBuilder(
          future: quote,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              List<QuotesDatabaseModel>? data = snapshot.data;
              if (data == null || data.isEmpty) {
                return const Center(
                  child: Text("No data available..."),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      height: width * 0.9,
                      width: width,
                      margin: EdgeInsets.only(bottom: height * 0.016),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(height * 0.008),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(height * 0.014),
                            child: Text(
                              data[0].quote,
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                          ),
                          Container(
                            height: height * 0.068,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(height * 0.008),
                                bottomRight: Radius.circular(height * 0.008),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: height * 0.016,
                                right: height * 0.016,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.favorite_border),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        const Text("Like"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.download),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        const Text("Save"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await Clipboard.setData(
                                        ClipboardData(text: data[0].quote),
                                      ).then(
                                        (_) {
                                          Get.snackbar(
                                            "Copied",
                                            "Quote copied to clipboard...",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor:
                                                Colors.grey.shade400,
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.copy),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        const Text("Copy"),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await Share.share(data[0].quote);
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.share),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        const Text("Share"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
