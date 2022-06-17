import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/eveluate.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/pages/products/controllers/product_controller.dart';
import 'package:freshfood/src/pages/products/widget/bottom_navigation_product.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DetailProductPage extends StatefulWidget {
  String id;
  DetailProductPage({this.id});
  @override
  State<StatefulWidget> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedImage = 0;
  final productController = Get.put(ProductDetailController());
  final cartController = Get.put(CartController());
  @override
  void initState() {
    super.initState();
    productController.getDetailProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                PhosphorIcons.arrow_left,
                color: Colors.white,
                size: 8.w,
              ),
            ),
            title: Center(
              child: Text(
                "Chi tiết Sản phẩm",
              ),
            ),
            actions: [
              Badge(
                position: BadgePosition.topEnd(top: 0, end: 3),
                animationDuration: Duration(milliseconds: 300),
                animationType: BadgeAnimationType.slide,
                borderSide: BorderSide(color: Colors.white),
                badgeColor: Colors.transparent,
                badgeContent: GetBuilder<CartController>(
                    init: cartController,
                    builder: (_) => _.totalQuantity == null
                        ? Text(
                            '0',
                            style:
                                TextStyle(color: Colors.white, fontSize: 2.5.w),
                          )
                        : Text(
                            _.totalQuantity,
                            style:
                                TextStyle(color: Colors.white, fontSize: 2.5.w),
                          )),
                child: IconButton(
                  // padding: EdgeInsets.zero,
                  // constraints: BoxConstraints(),
                  onPressed: () {
                    Get.toNamed(Routes.CART);
                  },
                  icon: Icon(
                    PhosphorIcons.shopping_cart,
                    color: Colors.white,
                    size: 8.w,
                  ),
                ),
              )
            ]),
        bottomNavigationBar: BottomNavigationProduct(
          productController: productController,
        ),
        body: SingleChildScrollView(
            child: GetBuilder<ProductDetailController>(
          init: productController,
          builder: (_) => _.product.image == null
              ? Container(
                  height: 50.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                )
              : Column(
                  children: [
                    GetBuilder<ProductDetailController>(
                      init: productController,
                      builder: (_) => _.product.image == null
                          ? Container()
                          : Column(
                              children: [
                                SizedBox(
                                  child: GestureDetector(
                                    onHorizontalDragEnd: (details) {
                                      setState(() {
                                        if (details.primaryVelocity < 0) {
                                          if (selectedImage ==
                                              _.product.image.length - 1)
                                            selectedImage = 0;
                                          else
                                            selectedImage++;
                                        }
                                        if (details.primaryVelocity > 0) {
                                          if (selectedImage == 0)
                                            selectedImage =
                                                _.product.image.length - 1;
                                          else
                                            selectedImage--;
                                        }
                                      });
                                    },
                                    child: AspectRatio(
                                      aspectRatio: 1.2,
                                      child: Image.network(
                                        _.product.image[selectedImage],
                                        fit: BoxFit.fitHeight,
                                        width: 80.w,
                                        height: 70.w,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 3.w),
                                Container(
                                  padding: new EdgeInsets.only(
                                      left: 5.w, right: 5.w),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ...List.generate(
                                            _.product.image.length,
                                            (index) => buildSmallPreview(
                                                index, _.product.image))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    detail(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => Text(_.product.name.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ),
                          SizedBox(height: 3.w),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => _.product.price == null
                                  ? Container()
                                  : _.product.price ==
                                              _.product.priceDiscount ||
                                          _.product.priceDiscount == 0
                                      ? Text(
                                          formatMoney(_.product.price),
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 6.w),
                                        )
                                      : Text(
                                          formatMoney(_.product.price),
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 4.w),
                                        ),
                            ),
                          ),
                          SizedBox(height: 3.w),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => _.product.priceDiscount == null
                                  ? Container()
                                  : _.product.price ==
                                              _.product.priceDiscount ||
                                          _.product.priceDiscount == 0
                                      ? SizedBox()
                                      : Text(
                                          formatMoney(_.product.priceDiscount),
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 6.w),
                                        ),
                            ),
                          ),
                          SizedBox(height: 3.w),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => _.product.starAVG == null ||
                                      _.product.starAVG == 0
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      child: Text(
                                        "chưa có đánh giá",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 4.w),
                                      ),
                                    )
                                  : Row(children: [
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      IgnorePointer(
                                        child: RatingBar.builder(
                                          initialRating:
                                              _.product.starAVG.toDouble(),
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 6.w,
                                          // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),

                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        _.product.starAVG.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 6.w),
                                      ),
                                    ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 17.sp, right: 20.sp, top: 17.sp),
                            child: Text(
                              'Khối lượng: ${_.product.weight.toString()} kg',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 17.sp, right: 20.sp, top: 17.sp),
                            child: GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => _.product.detail == null
                                  ? Container()
                                  : Text(
                                      _.product.detail,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    detail(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5.sp),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  //                   <--- left side
                                  color: Colors.grey.shade300,
                                  width: 2.sp,
                                ),
                              ),
                            ),
                            child: GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => (_.product.eveluateCount ==
                                          null ||
                                      _.product.starAVG == null)
                                  ? Container()
                                  : Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              child: Text(
                                                'ĐÁNH GIÁ SẢN PHẨM',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.sp),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w),
                                              child: Row(children: [
                                                IgnorePointer(
                                                  child: RatingBar.builder(
                                                    initialRating: _
                                                        .product.starAVG
                                                        .toDouble(),
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 5.w,
                                                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate:
                                                        (double value) {},
                                                  ),
                                                ),
                                                Text(
                                                    '${_.product.starAVG}/5 (${_.product.eveluateCount} đánh giá)')
                                              ]),
                                            ),
                                          ],
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Get.toNamed(
                                                  Routes.EVELUATE_DETAIL,
                                                  arguments: {
                                                    'productId': _.product.id
                                                  });
                                            },
                                            child: Text(
                                              'Xem tất cả',
                                              style: TextStyle(
                                                  color: Colors.orangeAccent),
                                            ))
                                      ],
                                    ),
                            ),
                          ),
                          Container(
                            height: 200.sp,
                            child: GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => _.eveluates.length == 0
                                  ? Container(
                                      child: Center(
                                        child: Text(
                                          'Chưa có đánh giá cho sản phẩm này',
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 15.sp),
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: _.eveluates.length,
                                      itemBuilder: (context, index) {
                                        return eveluate(
                                          eveluate_detail: _.eveluates[index],
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        )));
  }

  GestureDetector buildSmallPreview(int index, List<String> listImage) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.all(3),
        height: 10.h,
        width: 18.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: selectedImage == index
                    ? kPrimaryColor
                    : Colors.transparent)),
        child:
            // CachedNetworkImage(
            //   imageUrl: listImage[index],
            //   fit: BoxFit.cover,
            //   // height: 70.sp,
            //   // width: 70.sp,
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // ),
            Image.network(
          listImage[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class eveluate extends StatelessWidget {
  EveluateModel eveluate_detail;
  eveluate({Key key, this.eveluate_detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.sp, right: 5.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            //                   <--- left side
            color: Colors.grey.shade300,
            width: 2.sp,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Row(children: [
              CircleAvatar(
                  backgroundImage: NetworkImage(eveluate_detail.avatar)),
              SizedBox(
                width: 4.sp,
              ),
              Text(eveluate_detail.name)
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: IgnorePointer(
              child: RatingBar.builder(
                initialRating: eveluate_detail.star.toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 5.w,
                // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {},
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.w),
              child: Text(
                eveluate_detail.content,
                style: TextStyle(fontSize: 12.sp),
              )),
        ],
      ),
    );
  }
}

class detail extends StatelessWidget {
  const detail({Key key, @required this.color, @required this.child})
      : super(key: key);
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 300,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
