import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controllers/image_capture_controller.dart';
import 'package:quotes_app/models/quotes_database_model.dart';
import 'package:quotes_app/utils/globals.dart';
import 'package:quotes_app/utils/helpers/dbHelper.dart';

class QuoteDetailsPage extends StatefulWidget {
  const QuoteDetailsPage({super.key});

  @override
  State<QuoteDetailsPage> createState() => _QuoteDetailsPageState();
}

class _QuoteDetailsPageState extends State<QuoteDetailsPage> {
  ImageCaptureController imageCaptureController =
      Get.find<ImageCaptureController>();

  @override
  void initState() {
    super.initState();

    quote = DBHelper.dbHelper
        .fetchQuote(quoteId: quoteId!, categoryName: categoryName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
              GlobalKey screenshotGlobalKey = GlobalKey();
              return Stack(
                alignment: Alignment(height * 0, height * 0.0011),
                children: [
                  RepaintBoundary(
                    key: screenshotGlobalKey,
                    child: Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(backGroundImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(height * 0.014),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: height * 0.3,
                            ),
                            Text(
                              '“ ${data[0].quote} ”',
                              style: TextStyle(
                                fontSize: height * 0.03,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            (data[0].quoteAuthor != "Unknown")
                                ? Text(
                                    "— ${data[0].quoteAuthor}",
                                    style: TextStyle(
                                      fontSize: height * 0.03,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(height * 0.01),
                    child: Container(
                      height: height * 0.068,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(height * 0.014),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: height * 0.016,
                          right: height * 0.016,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (data[0].isFavorite == 0) {
                                  DBHelper.dbHelper
                                      .insertFavoriteQuotes(data: data[0]);

                                  quote = DBHelper.dbHelper.fetchAllQuotes(
                                      categoryName: categoryName!);
                                  setState(() {});
                                } else {
                                  DBHelper.dbHelper.deleteFromFavoriteQuote(
                                    quoteId: data[0].quoteId,
                                    quoteCategory: data[0].quoteCategory,
                                  );

                                  quote = DBHelper.dbHelper.fetchAllQuotes(
                                      categoryName: categoryName!);
                                  setState(() {});
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  (data[0].isFavorite == 0)
                                      ? const Icon(
                                          Icons.favorite_border,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                        ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  const Text(
                                    "Like",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                imageCaptureController
                                    .captureImage(
                                        screenshotGlobalKey:
                                            screenshotGlobalKey)
                                    .then(
                                      (value) => Get.snackbar(
                                        "Saved",
                                        "Image saved successfully in gallery...",
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.download,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Get.toNamed("/backGroundThemePage");
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.image),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  const Text("Themes"),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.wallpaper),
                                  SizedBox(
                                    width: width * 0.01,
                                  ),
                                  const Text("Wallpaper"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.04,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await imageCaptureController.shareImage(
                                screenshotGlobalKey: screenshotGlobalKey,
                                data: data[0]);
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
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
    );
  }
}
