import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/models/categories_database_model.dart';
import 'package:quotes_app/utils/globals.dart';
import 'package:quotes_app/utils/helpers/dbHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> searchCategoryFormKey = GlobalKey<FormState>();
  TextEditingController searchCategoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllCategory = DBHelper.dbHelper.fetchAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Best Quotes"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
        ],
      ),
      body: Form(
        key: searchCategoryFormKey,
        child: Padding(
          padding: EdgeInsets.all(height * 0.016),
          child: Column(
            children: [
              TextFormField(
                controller: searchCategoryController,
                onChanged: (value) {},
                scrollPhysics: const BouncingScrollPhysics(),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search...",
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(width * 0.08),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchCategoryController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.016,
              ),
              FutureBuilder(
                future: fetchAllCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    List<CategoryDatabaseModel>? data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return const Center(
                        child: Text("No Data Available"),
                      );
                    } else {
                      return Expanded(
                        child: GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: height * 0.016,
                            mainAxisSpacing: height * 0.016,
                            childAspectRatio: 5 / 3,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                Get.toNamed("/categoryPage");
                                categoryName = data[index].categoryName;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.primaries[index % 18].shade400,
                                  borderRadius:
                                      BorderRadius.circular(height * 0.008),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(height * 0.014),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data[index].categoryId}",
                                        style: TextStyle(
                                          fontSize: height * 0.025,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional.bottomEnd,
                                        child: Text(
                                          data[index].categoryName,
                                          style: TextStyle(
                                            fontSize: height * 0.022,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
