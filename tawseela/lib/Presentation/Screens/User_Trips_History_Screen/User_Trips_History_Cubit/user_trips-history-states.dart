import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawseela/Data/Network/failure.dart';

abstract class UserTripsHistoryStates {}

class UserTripsHistoryInitialState extends UserTripsHistoryStates {}

class UserTripsHistoryLoadingState extends UserTripsHistoryStates {}

class UserTripsHistorySuccessState extends UserTripsHistoryStates {}

class UserTripsHistoryErrorState extends UserTripsHistoryStates {
  final Failure failure;
  UserTripsHistoryErrorState(this.failure);
}

class ChangeSelectedFilterState extends UserTripsHistoryStates {}
