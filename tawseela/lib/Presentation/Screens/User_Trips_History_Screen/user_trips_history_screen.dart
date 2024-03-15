import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Screens/User_Trips_History_Screen/User_Trips_History_Cubit/user_trios_history_cubit.dart';
import 'package:tawseela/Presentation/Screens/User_Trips_History_Screen/User_Trips_History_Cubit/user_trips-history-states.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/no_internet_box.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/trip_card.dart';
import 'package:tawseela/Presentation/Widgets/back_arrow.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';

class UserTripsHistoryScreen extends StatelessWidget {
  const UserTripsHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserTripsHistoryCubit, UserTripsHistoryStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = UserTripsHistoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const BackArrow(),
            title: MyText(
              text: "Trips History",
              size: AppSizes.s20,
            ),
            actions: [
              DropdownButton(
                value: cubit.selectedFilter,
                onChanged: (value) {
                  cubit.changeSelectedFilter(value!);
                },
                items: cubit.filters.map((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: MyText(
                      text: e,
                      size: AppSizes.s15,
                      style: Theme.of(context).textTheme.headlineMedium!,
                    ),
                  );
                }).toList(),
                dropdownColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
          body: (state is UserTripsHistorySuccessState) ?
                Padding(
                  padding: const EdgeInsets.all(AppSizes.s15),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cubit.getUserTripsHistory();
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: [
                          MyText(
                            text: cubit.defaultFilter![index],
                            size: AppSizes.s15,
                            style: Theme.of(context).textTheme.displayLarge!,
                          ),
                          const SizedBox(
                            height: AppSizes.s5,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int indx) {
                                return TripHistoryCard(tripData: cubit.defaultFilterMap[cubit.defaultFilter![index]]![indx]);
                              },
                              itemCount: cubit.defaultFilterMap[cubit.defaultFilter![index]]!.length),
                          const SizedBox(
                            height: AppSizes.s5,
                          )
                        ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemCount: cubit.defaultFilterMap.keys.toList().length,
                    ),
                  ),
                ) :
                (state is UserTripsHistoryErrorState) ?
                    NoInternetBox(message: state.failure.message!, fun: () {
                      cubit.getUserTripsHistory();
                    }) :
                    const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
