import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/helpers/get_session.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/home/controllers/book_controller.dart';
import 'package:freshfood/src/pages/home/controllers/product_controller.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'components/header.dart';
import 'components/recoment_product.dart';
import 'components/title_with_button_more.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bookController = Get.put(BookController());
  ScrollController scrollController = ScrollController();
  final CarouselController _controller = CarouselController();
  final productController = Get.put(ProductController());

  int _current = 0;
  @override
  void initState() {
    super.initState();
    productController.initialController();
    productController.getRecommendProduct();
    productController.getProductUser();
    // bookController.getBooks();
    // scrollController.addListener(() {
    //   if (scrollController.position.atEdge) {
    //     if (scrollController.offset != 0.0) {
    //       bookController.getBooks();
    //     }
    //   }
    // });
  }

  final List<Widget> imageSliders = listDefaultImage
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(item, fit: BoxFit.cover, width: 100.w),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Container()),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: buildAppBar(),
        body: Container(
            height: 100.h,
            width: 100.w,
            child: Column(children: [
              Header(size),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: CarouselSlider(
                          items: imageSliders,
                          carouselController: _controller,
                          options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: false,
                              aspectRatio: 2.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                      ),
                      TitleWithButton(
                          title: "Nổi bật",
                          onpress: () {
                            Get.toNamed(Routes.PRODUCT);
                          }),
                      SizedBox(height: 10.sp),
                      Container(
                        child: StreamBuilder(
                          stream: productController.listProductRecommend,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return Container(
                              width: 100.w,
                              height: 200.sp,
                              child: ListView.builder(
                                controller: scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return RecomendProductCard(
                                    product: ProductModel.fromMap(
                                        snapshot.data[index]),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      TitleWithButton(
                          title: "Đã xem gần đây",
                          onpress: () {
                            Get.toNamed(Routes.PRODUCT);
                          }),
                      SizedBox(height: 10.sp),
                      Container(
                        child: StreamBuilder(
                          stream: productController.listProductUser,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                child: Center(
                                  child: Container(),
                                ),
                              );
                            }

                            return Container(
                              width: 100.w,
                              height: 200.sp,
                              child: ListView.builder(
                                controller: scrollController,
                                // gridDelegate:
                                //     SliverGridDelegateWithFixedCrossAxisCount(
                                //   crossAxisCount: 2,
                                //   crossAxisSpacing: 4.0,
                                //   mainAxisExtent: 4.0,
                                // ),
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return RecomendProductCard(
                                    product: ProductModel.fromMap(
                                        snapshot.data[index]),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ])));
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: Image.asset("assets/images/logo.png"),
      title: Center(
        child: Text(
          "Chào " + getSession(),
        ),
      ),
      actions: [
        Image.asset("assets/images/logo.png"),
      ],
    );
  }
}
