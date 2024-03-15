import 'package:flutter/Material.dart';

class MyCircleAvatar extends StatelessWidget {

  double radius = 30;
  Widget child = const Placeholder();
  Color? color;

  MyCircleAvatar({Key? key,this.radius = 30,required this.child, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: child,
        );
  }
}
