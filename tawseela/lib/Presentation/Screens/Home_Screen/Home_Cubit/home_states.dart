import 'package:tawseela/Data/Network/failure.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class AddMarkerState extends HomeStates {}


class GetAddressState extends HomeStates {}

class LoadingState extends HomeStates {}
class GetPredictionsLoadingState extends HomeStates {}

class ErrorState extends HomeStates {
  final Failure failure;
  ErrorState(this.failure);
}

class UpdatePickUpLocationState extends HomeStates {}

class GetPredictionsSuccessState extends HomeStates {}

class GetPredictionsErrorState extends HomeStates {
  final Failure failure;
  GetPredictionsErrorState(this.failure);
}

class UpdateDropOffLocationState extends HomeStates {}

class GetPlaceDetailsErrorState extends HomeStates {
  final Failure failure;
  GetPlaceDetailsErrorState(this.failure);
}

class FlipIsSearchingState extends HomeStates {}

class GetRouteSuccessState extends HomeStates {}

class InitializeGeoFireListenerState extends HomeStates {}

class GetAvailableDriversSuccessState extends HomeStates {}

class HomeRideRequestAcceptedRequestState extends HomeStates {}

class SaveRideRequestInfoState extends HomeStates {}

class CancelRideState extends HomeStates {}

class ChangeRateStatusState extends HomeStates {}

class RateDriverState extends HomeStates {}

class EndTripSuccessState extends HomeStates {}
class SelectVechleSuccessState extends HomeStates {}
class FetchDriverDataState extends HomeStates {}
class FetchDriverLocationState extends HomeStates {}
class ProfileGetDataErrorState extends HomeStates {}
class ProfileGetDataSuccessState extends HomeStates {}

class GetAssignedDriverSuccessState extends HomeStates {}
class GetAssignedDriverErrorState extends HomeStates {
  final Failure failure;
  GetAssignedDriverErrorState(this.failure);
}
class OnTripState extends HomeStates {}

class ChangeMapTypeState extends HomeStates {}
