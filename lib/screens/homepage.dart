import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:submart/Resources/cloud_methods.dart';
import 'package:submart/models/user_model.dart';
import 'package:submart/screens/screen_layout.dart';
import 'package:submart/utils/color_theme.dart';
import 'package:submart/utils/constants.dart';
import 'package:submart/widgets/banner_ad.dart';
import 'package:submart/widgets/categories_list_view_bar.dart';
import 'package:submart/widgets/loading_widget.dart';
import 'package:submart/widgets/product_list_view.dart';
import 'package:submart/widgets/search_bar.dart';
import 'package:submart/widgets/simple_product.dart';
import 'package:submart/widgets/user_details.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future getData() async {
    List<Widget> temp70 =
        await CloudFirestoreClass().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreClass().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreClass().getProductsFromDiscount(50);
    List<Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);
    print("Done");
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  // List<Widget> testchildren = [
  // //   SimpleProductWidget(
  // //       url: "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",),
  // //   SimpleProductWidget(
  // //       url: "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg"),
  // //   SimpleProductWidget(
  // //       url: "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg"),
  // //   SimpleProductWidget(
  // //       url: "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg"),
  // //   SimpleProductWidget(
  // //       url: "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg"),
  // //   SimpleProductWidget(
  // //       url: "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kAppBarHeight / 2,
                      ),
                      const CategoriesHorizontalListViewBar(),
                      const AdBannerWidget(),
                      ProductsShowcaseListView(
                          title: "Upto 70% Off", children: discount70!),
                      ProductsShowcaseListView(
                          title: "Upto 60% Off", children: discount60!),
                      ProductsShowcaseListView(
                          title: "Upto 50% Off", children: discount50!),
                      ProductsShowcaseListView(
                          title: "Explore", children: discount0!),
                    ],
                  ),
                ),
                UserDetailsBar(
                  offset: offset,
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
