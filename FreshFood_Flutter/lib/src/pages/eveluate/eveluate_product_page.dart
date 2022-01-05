import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/eveluate.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/eveluate/controller/eveluate_controller.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/detail_product_screen.dart';
import 'package:freshfood/src/pages/products/widget/bottom_navigation_product.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EveluateProductPage extends StatefulWidget {
  String productId;
  EveluateProductPage({this.productId});
  @override
  State<StatefulWidget> createState() => _EveluateProductPageState();
}

class _EveluateProductPageState extends State<EveluateProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedImage = 0;
  final eveluateController = Get.put(EveluateController());

  @override
  void initState() {
    super.initState();
    eveluateController.getAllEveluate(widget.productId, 1, 15);
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
          title: Text(
            "Xem đánh giá",
          ),
        ),
        body: GetBuilder<EveluateController>(
          init: eveluateController,
          builder: (_) => _.listEveluate.length == 0
              ? Container(
                  child: Center(
                    child: Text(
                      'Chưa có đánh giá cho sản phẩm này',
                      style: TextStyle(color: Colors.black38, fontSize: 15.sp),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _.listEveluate.length,
                  itemBuilder: (BuildContext context, int index) {
                    return eveluateDetail(
                      eveluate: _.listEveluate[index],
                    );
                  }),
        ));
  }
}

class eveluateDetail extends StatelessWidget {
  EveluateModel eveluate;
  eveluateDetail({Key key, this.eveluate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: 10.sp, left: 5.sp, right: 5.sp, bottom: 10.sp),
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
              CircleAvatar(backgroundImage: NetworkImage(eveluate.avatar)),
              SizedBox(
                width: 4.sp,
              ),
              Text(eveluate.name)
            ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: IgnorePointer(
              child: RatingBar.builder(
                initialRating: eveluate.star.toDouble(),
                direction: Axis.horizontal,
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
                eveluate.content,
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
