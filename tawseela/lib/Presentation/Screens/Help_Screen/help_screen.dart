import 'package:flutter/Material.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Widgets/back_arrow.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        title: MyText(
          text: 'Help',
          size: AppSizes.s20,
          style: Theme.of(context).textTheme.displayLarge!,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.s8),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s20),
                child: MyText(
                  text: 'How to use the app',
                  size: AppSizes.s20,
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s20),
                child: MyText(
                  text: 'How to use the app',
                  size: AppSizes.s20,
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s20),
                child: MyText(
                  text: 'How to use the app',
                  size: AppSizes.s20,
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s20),
                child: MyText(
                  text: 'How to use the app',
                  size: AppSizes.s20,
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s20),
                child: MyText(
                  text: 'How to use the app',
                  size: AppSizes.s20,
                  style: Theme.of(context).textTheme.displayLarge!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
