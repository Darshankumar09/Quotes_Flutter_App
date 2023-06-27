import 'package:flutter/material.dart';
import 'package:quotes_app/utils/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> searchCategoryFormKey = GlobalKey<FormState>();

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
                ),
              ),
              SizedBox(
                height: height * 0.016,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: height * 0.016,
                    mainAxisSpacing: height * 0.016,
                    childAspectRatio: 5 / 3,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.primaries[index % 18].shade400,
                        borderRadius: BorderRadius.circular(height * 0.008),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(height * 0.014),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("ABC"),
                            Align(
                              alignment: AlignmentDirectional.bottomEnd,
                              child: Icon(Icons.abc),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
