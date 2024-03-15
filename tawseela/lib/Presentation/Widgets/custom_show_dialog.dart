import 'package:flutter/Material.dart';

import '../Resources/color_manager.dart';
import '../Resources/values_manager.dart';
import 'my_text.dart';

class CustomShowDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;
  const CustomShowDialog({Key? key, required this.title, required this.content, required this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("lllllll");
        return Container();
  }
}

void customShowDialog({required BuildContext context,required String title, required dynamic content,required List<Widget> actions})
{
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: AppSizes.s20,
          title: MyText(text: title,size: AppSizes.s20,),
          content: content,
          actions: actions,
        );
      }
  );
}

