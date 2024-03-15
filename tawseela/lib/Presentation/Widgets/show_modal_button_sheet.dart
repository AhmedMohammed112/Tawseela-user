import 'package:flutter/Material.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';
import '../Resources/values_manager.dart';

class ShowErrorDialog extends StatelessWidget {
  final BuildContext c;
  final Failure failure;

  const ShowErrorDialog({Key? key, required this.failure, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: MyText(
        text: failure.message!,
        size: AppSizes.s20,
        style: Theme.of(context).textTheme.displayLarge!,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
            child: MyText(
              text: "ok",
              size: AppSizes.s20,
              style: Theme.of(context).textTheme.displayLarge!,
            ),
        ),
      ],
    );
  }
}