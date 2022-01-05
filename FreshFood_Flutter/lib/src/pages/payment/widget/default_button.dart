import 'package:flutter/material.dart';
import 'package:freshfood/src/public/styles.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final Function onPressed;
  const DefaultButton({
    Key key,
    this.btnText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: kPrimaryColor,
        textColor: Colors.white,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
        child: Text(btnText.toUpperCase()),
      ),
    );
  }
}
