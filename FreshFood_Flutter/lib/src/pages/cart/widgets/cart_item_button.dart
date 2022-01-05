import 'package:flutter/material.dart';

class CartItemButton extends StatelessWidget {
  final IconData icon;
  final Function action;
  CartItemButton(this.icon, this.action);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: FlatButton(
        onPressed: action,
        color: Colors.white,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Icon(
          icon,
          color: Colors.green,
          size: 16,
        ),
      ),
    );
  }
}
