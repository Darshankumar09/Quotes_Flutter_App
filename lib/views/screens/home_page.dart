import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controllers/image_capture_controller.dart';
import 'package:quotes_app/controllers/theme_controller.dart';
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
  ImageCaptureController imageCaptureController =
      Get.put(ImageCaptureController());

  @override
  void initState() {
    super.initState();
    fetchAllCategory = DBHelper.dbHelper.fetchAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        endDrawer: Drawer(
          child: Padding(
            padding: EdgeInsets.all(height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Center(
                  child: CircleAvatar(
                    foregroundImage: const AssetImage(
                      "assets/images/category_images/32.png",
                    ),
                    radius: height * 0.092,
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.home_outlined),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        "Home Page",
                        style: TextStyle(
                          fontSize: height * 0.024,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                          fontSize: height * 0.024,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.grid_view),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        "Browse",
                        style: TextStyle(
                          fontSize: height * 0.024,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/favoritePage');
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.favorite_border),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        "Favourite Page",
                        style: TextStyle(
                          fontSize: height * 0.024,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Divider(),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.person_outline),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: height * 0.024,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.logout_outlined),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: height * 0.024,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const Divider(),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Theme",
                      style: TextStyle(
                        fontSize: height * 0.024,
                      ),
                    ),
                    Switch(
                      value: Provider.of<ThemeController>(context)
                          .themeModel
                          .isDark,
                      onChanged: (val) {
                        Provider.of<ThemeController>(context, listen: false)
                            .changeTheme(val: val);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Best Quotes"),
        ),
        body: Form(
          key: searchCategoryFormKey,
          child: Padding(
            padding: EdgeInsets.all(height * 0.016),
            child: Column(
              children: [
                TextFormField(
                  controller: searchCategoryController,
                  onChanged: (value) {
                    setState(() {
                      fetchAllCategory =
                          DBHelper.dbHelper.fetchSearchCategory(data: value);
                    });
                  },
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
                        setState(() {
                          searchCategoryController.clear();
                          fetchAllCategory =
                              DBHelper.dbHelper.fetchAllCategory();
                        });
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
                        return Center(
                          child: Image.asset(
                            "assets/images/other_images/no_data.png",
                            height: height * 0.35,
                            width: height * 0.35,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
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
                                  categoryImage = data[index].categoryImage;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.primaries[index % 18].shade400,
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
                                          data[index].categoryName,
                                          style: TextStyle(
                                            fontSize: height * 0.024,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: Image.asset(
                                            data[index].categoryIcon,
                                            height: height * 0.055,
                                            width: height * 0.055,
                                            fit: BoxFit.cover,
                                            color: Colors.black,
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
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
