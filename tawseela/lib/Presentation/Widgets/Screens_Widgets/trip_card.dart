import 'package:flutter/Material.dart';
import 'package:tawseela/Domain/Models/request_details-info.dart';
import 'package:tawseela/Domain/Models/trip_data.dart';

import '../../Resources/values_manager.dart';
import '../my_text.dart';

class TripHistoryCard extends StatelessWidget { 
  final RequestDetailsInfo tripData;
  const TripHistoryCard({super.key,required this.tripData});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            MyText(
              text:
              'From: ${tripData!.originAddress}',
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            MyText(
              text:
              'To: ${tripData.destinationAddress}',
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            MyText(
              text:
              'Date: ${tripData.date}',
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            MyText(
              text:
              'Price: ${tripData.fareAmount}',
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            MyText(
              text:
              'Status: ${tripData.tripStatus}',
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
            MyText(
              text:
              "Trip rate: ${tripData.rating}",
              size: AppSizes.s15,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!,
            ),
          ],
        ),
      ),
    );
  }
}
