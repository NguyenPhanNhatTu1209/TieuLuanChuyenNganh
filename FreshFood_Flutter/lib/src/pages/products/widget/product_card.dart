import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/home/controllers/product_controller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/product_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  ProductCard({this.product});
  @override
  State<StatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 60.w,
      margin: EdgeInsets.only(left: 5.sp),
      child: GestureDetector(
        onTap: () => {
          ProductRepository()
              .createProductUser(widget.product.id)
              .then((value) => {productController.getProductUser()}),
          Get.toNamed(Routes.DETAIL_PRODUCT,
              arguments: {"id": widget.product.id})
        },
        child: Container(
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  widget.product.image[0],
                  fit: BoxFit.cover,
                  height: 100.sp,
                  width: 50.w,
                ),
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.23))
                    ]),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(widget.product.name.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                          ),
                          Row(
                            children: [
                              Text(
                                formatMoney(widget.product.price),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(
                                      fontSize: widget.product.priceDiscount ==
                                                  0 ||
                                              widget.product.priceDiscount ==
                                                  widget.product.price
                                          ? 13.sp
                                          : 9.sp,
                                      decoration:
                                          widget.product.priceDiscount == 0 ||
                                                  widget.product
                                                          .priceDiscount ==
                                                      widget.product.price
                                              ? null
                                              : TextDecoration.lineThrough,
                                      color: widget.product.priceDiscount ==
                                                  0 ||
                                              widget.product.priceDiscount ==
                                                  widget.product.price
                                          ? kPrimaryColor
                                          : Colors.red,
                                    ),
                              ),
                              widget.product.priceDiscount == 0 ||
                                      widget.product.priceDiscount ==
                                          widget.product.price
                                  ? SizedBox()
                                  : Text(
                                      formatMoney(widget.product.priceDiscount),
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .copyWith(
                                              color: kPrimaryColor,
                                              fontSize: 13.sp),
                                    ),
                            ],
                          ),
                          IgnorePointer(
                            child: RatingBar.builder(
                              initialRating: widget.product.starAVG.toDouble(),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 6.w,
                              // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),

                              onRatingUpdate: (rating) {},
                            ),
                          ),
                          SizedBox(height: 5.sp),
                          Container(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Đã bán ' + widget.product.sold.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
