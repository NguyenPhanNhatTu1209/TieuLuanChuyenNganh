import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/eveluate.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'controller/eveluate_controller.dart';

class EveluatePage extends StatefulWidget {
  List<EveluateModel> listProduct;
  EveluatePage({this.listProduct});
  @override
  State<StatefulWidget> createState() => _EveluatePageState();
}

class _EveluatePageState extends State<EveluatePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final eveluateController = Get.put(EveluateController());

  List<String> listImage = [
    "https://photo-cms-baonghean.zadn.vn/w607/Uploaded/2021/tuqzxgazsnzm/2018_11_08/143638-1.jpg",
    "https://img.lovepik.com/element/40031/4942.png_860.png",
    "http://img.vinanet.vn/zoom/500/Uploaded/ThuHai/NongSan/pork_JSGL.jpg",
  ];

  int selectedImage = 0;

  @override
  void initState() {
    super.initState();
    widget.listProduct.forEach((element) {
      element.star = 5;
      element.content = "";
    });
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
          title: Container(
            padding: EdgeInsets.only(
              left: 60.sp,
            ),
            child: Text(
              "Đánh giá",
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: 20.sp, top: 20.sp, right: 20.sp, bottom: 5.sp),
              child: Row(children: [
                Icon(
                  PhosphorIcons.heart_bold,
                  size: 30.sp,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Expanded(
                  child: Text(
                      "Bạn vui lòng bỏ ít thời gian để đánh giá sản phẩm bên mình nhé!",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12.sp)),
                )
              ]),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.listProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    final EveluateModel productModel =
                        widget.listProduct[index];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20.sp, left: 20.sp),
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.grey,
                            child: Row(
                              children: [
                                Image.network(
                                  productModel.image[0],
                                  fit: BoxFit.cover,
                                  height: 50.sp,
                                  width: 50.sp,
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Expanded(
                                  child: Text(productModel.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                ),
                                Icon(PhosphorIcons.caret_right)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30.sp),
                          child: RatingBar.builder(
                            initialRating: 5,
                            direction: Axis.horizontal,
                            // allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 15.w,
                            // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            minRating: 1,
                            onRatingUpdate: (double value) {
                              widget.listProduct[index].star = value.toInt();
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15.sp),
                          child: Container(
                            color: Colors.grey.shade100,
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.top,
                              onChanged: (value) {
                                widget.listProduct[index].content = value;
                              },
                              decoration: const InputDecoration(
                                  hintText:
                                      'Nhập nội dung mà bạn muốn đánh giá!',
                                  labelText: "Nội Dung",
                                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                                  alignLabelWithHint: true,
                                  // border: Border.all(color: Colors.blueAccent),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0)),
                                  fillColor: Colors.grey),
                              maxLines: 7,
                              validator: (String value) {
                                return (value != null && value.contains('@'))
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            DefaultButton(
              btnText: 'Đánh giá ngay',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      );
                    },
                    barrierColor: Color(0x80000000),
                    barrierDismissible: false);
                eveluateController.createEveluate(widget.listProduct);
              },
            )
          ],
        ));
  }

//   GestureDetector buildSmallPreview(int index) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedImage = index;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: 5),
//         padding: EdgeInsets.all(3),
//         height: 10.h,
//         width: 18.w,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//                 color: selectedImage == index
//                     ? kPrimaryColor
//                     : Colors.transparent)),
//         child: Image.network(listImage[index]),
//       ),
//     );
//   }
// }

// class detail extends StatelessWidget {
//   const detail({Key key, @required this.color, @required this.child})
//       : super(key: key);
//   final Color color;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       // height: 300,
//       margin: EdgeInsets.only(top: 20),
//       padding: EdgeInsets.only(top: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//         ),
//       ),
//       child: child,
//     );
//   }
}
