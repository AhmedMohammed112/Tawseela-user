import 'package:flutter/Material.dart';

import '../../../Domain/Models/request_details-info.dart';
import '../../Resources/values_manager.dart';
import '../my_text.dart';

class TripItem extends StatelessWidget {
  List<String>? defaultFilter;
  Map<String,List<RequestDetailsInfo>> defaultFilterMap = {}; 
  
  TripItem({Key? key,required this.defaultFilter,required this.defaultFilterMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(children: [
          MyText(
            text: defaultFilter![index],
            size: AppSizes.s15,
            style: Theme.of(context).textTheme.displayLarge!,
          ),
          const SizedBox(
            height: AppSizes.s5,
          ),
          TripItem(defaultFilter: defaultFilter,defaultFilterMap: defaultFilterMap),
          const SizedBox(
            height: AppSizes.s5,
          )
        ]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemCount:   defaultFilterMap.keys.toList().length,
    );
  }
}
