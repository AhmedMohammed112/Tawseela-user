import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Domain/Models/request_details-info.dart';
import 'package:tawseela/Domain/Usecases/get_ride_requests_usecase.dart';
import 'package:tawseela/Presentation/Screens/User_Trips_History_Screen/User_Trips_History_Cubit/user_trips-history-states.dart';

import '../../../../App/Dependncy_Injection/di.dart';

class UserTripsHistoryCubit extends Cubit<UserTripsHistoryStates> {
  UserTripsHistoryCubit() : super(UserTripsHistoryInitialState());

  static UserTripsHistoryCubit get(context) => BlocProvider.of(context);

  List<RequestDetailsInfo> userTripsHistory = [];

  GetRideRequestsUsecase getRideRequestsUsecase = sl<GetRideRequestsUsecase>();


  Future<void> getUserTripsHistory() async {
    emit(UserTripsHistoryLoadingState());
    final response = await getRideRequestsUsecase.execute(null);
    response.fold(
      (error) {
        print(error.message);
        emit(UserTripsHistoryErrorState(error));
      },
      (data) {
        userTripsHistory = data;
        initDefaultFilter();
        emit(UserTripsHistorySuccessState());
      },
    );
  }

  Map<String, int> getUserTripsHistoryTotalRatingCount() {
    int fiveStars = 0;
    int fourStars = 0;
    int threeStars = 0;
    int twoStars = 0;
    int oneStars = 0;
    for (int i = 0; i < userTripsHistory.length; i++) {
      if (userTripsHistory[i].rating == 5) {
        fiveStars++;
      } else if (userTripsHistory[i].rating == 4) {
        fourStars++;
      } else if (userTripsHistory[i].rating == 3) {
        threeStars++;
      } else if (userTripsHistory[i].rating == 2) {
        twoStars++;
      } else if (userTripsHistory[i].rating == 1) {
        oneStars++;
      }
    }
    return {
      "fiveStars": fiveStars,
      "fourStars": fourStars,
      "threeStars": threeStars,
      "twoStars": twoStars,
      "oneStars": oneStars,
    };
  }


  Map<String, List<RequestDetailsInfo>> getUserTripsHistoryByDate() {
    Map<String, List<RequestDetailsInfo>> tripsByDate = {};
    for (int i = 0; i < userTripsHistory.length; i++) {
      if (tripsByDate.containsKey(
          userTripsHistory[i].date.substring(0, 10))) {
        tripsByDate[userTripsHistory[i].date.substring(0, 10)]!.add(
            userTripsHistory[i]);
      } else {
        tripsByDate[userTripsHistory[i].date.substring(0, 10)] = [];
        tripsByDate[userTripsHistory[i].date.substring(0, 10)]!.add(
            userTripsHistory[i]);
      }
    }
    dates = tripsByDate.keys.toList();
    dates!.sort((a, b) => b.compareTo(a));
    return tripsByDate;
  }

  List<String>? dates;

  List<RequestDetailsInfo> getUserTripsHistoryByDateList(String date) {
    List<RequestDetailsInfo> tripsByDate = [];
    for (int i = 0; i < userTripsHistory.length; i++) {
      if (userTripsHistory[i].date.substring(0, 10) == date) {
        tripsByDate.add(userTripsHistory[i]);
      }
    }
    return tripsByDate;
  }

  Map<String, List<RequestDetailsInfo>> getUserTripsHistoryByRate() {
    Map<String, List<RequestDetailsInfo>> tripsByRate = {};
    for (int i = 0; i < userTripsHistory.length; i++) {
      if (tripsByRate.containsKey(userTripsHistory[i].rating.toString())) {
        tripsByRate[userTripsHistory[i].rating.toString()]!.add(
            userTripsHistory[i]);
      } else {
        tripsByRate[userTripsHistory[i].rating.toString()] =
        [userTripsHistory[i]];
      }
    }

    rates = tripsByRate.keys.toList();
    rates!.sort((a, b) => b.compareTo(a));
    return tripsByRate;
  }

  List<String>? rates;



  List<RequestDetailsInfo> getUserTripsHistoryByRateList(String rate) {
    List<RequestDetailsInfo> tripsByRate = [];
    for (int i = 0; i < userTripsHistory.length; i++) {
      if (userTripsHistory[i].rating.toString() == rate) {
        tripsByRate.add(userTripsHistory[i]);
      }
    }
    return tripsByRate;
  }

  Map<String, List<RequestDetailsInfo>> getUserTripsHistoryByStatus() {
    Map<String, List<RequestDetailsInfo>> tripsByStatus = {};
    for (int i = 0; i < userTripsHistory.length; i++) {
      if (tripsByStatus.containsKey(userTripsHistory[i].tripStatus)) {
        tripsByStatus[userTripsHistory[i].tripStatus]!.add(
            userTripsHistory[i]);
      } else {
        tripsByStatus[userTripsHistory[i].tripStatus!] =
        [userTripsHistory[i]];
      }
    }
    status = tripsByStatus.keys.toList();
    status!.sort((a, b) => b.compareTo(a));
    return tripsByStatus;
  }

  List<String>? status;




  List<RequestDetailsInfo> getUserTripsHistoryByStatusList(String status) {
    List<RequestDetailsInfo> tripsByStatus = [];
    for (int i = 0; i < userTripsHistory.length; i++) {
      if (userTripsHistory[i].tripStatus == status) {
        tripsByStatus.add(userTripsHistory[i]);
      }
    }
    return tripsByStatus;
  }

  List<String>? defaultFilter;
  Map<String,List<RequestDetailsInfo>> defaultFilterMap = {};

  void initDefaultFilter() {
    getUserTripsHistoryByDate();
    defaultFilter = dates;
    defaultFilterMap = getUserTripsHistoryByDate();
  }


  String selectedFilter = "Date";

  void changeSelectedFilter(String filter) {
    selectedFilter = filter;
    switch (filter) {
      case "Date":
        defaultFilter = dates;
        defaultFilterMap = getUserTripsHistoryByDate();
        break;
      case "Rate":
        getUserTripsHistoryByRate();
        defaultFilter = rates;
        defaultFilterMap = getUserTripsHistoryByRate();
        break;
      case "Status":
        getUserTripsHistoryByStatus();
        defaultFilter = status;
        defaultFilterMap = getUserTripsHistoryByStatus();
        break;
    }
    emit(ChangeSelectedFilterState());
    emit(UserTripsHistorySuccessState());
  }

  List<String> filters = [
    "Date",
    "Rate",
    "Status",
  ];
}