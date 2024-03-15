import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawseela/App/Notifications/notification_handler.dart';
import 'package:tawseela/App/Shared_Preferences/shared.dart';
import 'package:tawseela/Data/Response/request_details_info_response.dart';
import 'package:tawseela/Domain/Models/active_nearby_drivers.dart';
import 'package:tawseela/Domain/Models/direction_details_info.dart';
import 'package:tawseela/Domain/Models/driver_model.dart';
import 'package:tawseela/Domain/Usecases/cancel_trip_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_assigned_driver_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_direction_info_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_formatted-address_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_place_details_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_predictions_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_ride_requests_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_user_data_usecase.dart';
import 'package:tawseela/Domain/Usecases/rate_driver_usecase.dart';
import 'package:tawseela/Domain/Usecases/update_user_free_trips_count.dart';
import 'package:tawseela/Domain/Usecases/update_user_trips_count.dart';
import 'package:tawseela/Presentation/Resources/color_manager.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/available_rides_container.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/cancelled_trip-dialog.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/show_fare_dialog.dart';
import 'package:tawseela/App/Constants/constants.dart';
import 'package:tawseela/App/Dependncy_Injection/di.dart';
import 'package:tawseela/App/Helpers/geofire_helper.dart';
import 'package:tawseela/Domain/Models/autocomplete_prediction_model.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:tawseela/Domain/Models/user_model.dart';
import 'package:tawseela/Domain/Usecases/save_ride_request_info_usecase.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  final GetFormattedAddressUsecase getFormattedAddressUsecase =
      sl<GetFormattedAddressUsecase>();
  final GetPredictionsUsecase getPredictionsUsecase =
      sl<GetPredictionsUsecase>();
  final GetPlaceDetailsUsecase getPlaceDetailsUsecase =
      sl<GetPlaceDetailsUsecase>();
  final GetCurrentUserInfoUsecase getCurrentUserInfoUsecase =
      sl<GetCurrentUserInfoUsecase>();
  final GetDirectionDetailsInfoUsecase getDirectionDetailsInfoUsecase =
      sl<GetDirectionDetailsInfoUsecase>();
  final SaveRideRequestInfoUsecase saveRideRequestInfoUsecase =
      sl<SaveRideRequestInfoUsecase>();
  final GetRideRequestsUsecase getRideRequestsUsecase =
      sl<GetRideRequestsUsecase>();
  final GetActiveDriversUsecase getAssignedDriverUsecase =
      sl<GetActiveDriversUsecase>();
  final RateDriverUsecase rateDriverUsecase = sl<RateDriverUsecase>();
  final UpdateUserTripsCountUsecase updateUserTripsCountUsecase =
      sl<UpdateUserTripsCountUsecase>();
  final UpdateUserFreeTripsCountUsecase updateUserFreeTripsCountUsecase =
      sl<UpdateUserFreeTripsCountUsecase>();
  final CancelTripUsecase cancelTripUsecase = sl<CancelTripUsecase>();
  final SaveRideRequestUsecase saveRideRequestUsecase =
      sl<SaveRideRequestUsecase>();
  final ListenToRideRequestUseCase listenToRideRequestUseCase =
      sl<ListenToRideRequestUseCase>();

  LatLng? pickUpLocation = const LatLng(
      37.42796133580664, -122.085749655962); // Current User Location
  String? pickUpAddress; // Current User Address

  LatLng? dropOffLocation; // Destination User Location
  String? dropOffAddress; // Destination User Address

  Set<Marker> markers = {}; // Markers
  Set<Circle> circles = {}; // Circles
  Set<Polyline> polyLines = {}; // PolyLines

  DirectionDetailsInfo? directionDetailsInfo; // Direction Details Info

  List<ActiveNearbyDriver> onlineDrivers = []; // Online Drivers

  List<AutocompletePrediction> predictions = []; // Place AutoComplete Predictions

  String selectedVehicle = ''; // Selected Vehicle Type

  String driverId = 'Waiting';
  LatLng? driverLocation;
  String tripStatus = '';
  String tStatus = '';
  String? rideRequestId;
  double? fareAmount;

  GoogleMapController? controller;

  LatLng? defaultLatLng = const LatLng(0, 0);
  bool isDriversLoaded = false;

  DatabaseReference? allRideRequestsRef; // All Ride Requests Reference
  StreamSubscription<DatabaseEvent>? allRideRequestsSubscription; // All Ride Requests Subscription

  String? tempRideRequestId;
  AssignedDriver? tempAssignedDriver;

  void changeVehicleType(String value) {
    selectedVehicle = value;
    emit(SelectVechleSuccessState());
  }

  UserModel? myData; // Current User Data
  int freeTripsCount = 0; // Current User Free Trips Count

  // Get Current User Data
  void getUserData() async {
    emit(LoadingState());
    final result = await getCurrentUserInfoUsecase
        .execute(FirebaseAuth.instance.currentUser!.uid);
    result.fold((error) {
      emit(ProfileGetDataErrorState());
    }, (data) {
      myData = data;
      freeTripsCount = myData!.freeTrips;
      emit(ProfileGetDataSuccessState());
    });
  }

  AssignedDriver? assignedDriver; // Assigned Driver Data
  void getAssignedDriver() {
    assignedDriver = driversList.firstWhere((element) => element.id == driverId);
  }

  void incrementUserTripsCount() async {
    await updateUserTripsCountUsecase.execute(null);
  }

  void decrementUserFreeTripsCount() async {
    await updateUserFreeTripsCountUsecase.execute(null);
  }

  String rateStatus = '';
  Color rateStatusColor = ColorManager.green;
  double driverRate = 0.0;
  String commentReview = '';

  void submitDriverReview({String review = ''}) {
    emit(LoadingState());
    List reviews = tempAssignedDriver!.review;
    Review reviewModel = Review(
        id: FirebaseAuth.instance.currentUser!.uid,
        name: myData!.name,
        comment: review,
        rate: driverRate,
        image: myData!.image);
    reviews.add(reviewModel);
    List<Map<String, dynamic>> reviewsMap = [];
    for (var element in reviews) {
      reviewsMap.add(element.toMap());
    }

    double oldRating = tempAssignedDriver!.rating;
    double newRating = (oldRating + driverRate) / 2;

    rateDriverUsecase.execute(RateDriverUseCaseInput(
        driverId: driverId,
        rideRequestId: tempRideRequestId!,
        driverRate: newRating,
        reviews: reviewsMap));

    emit(FetchDriverDataState());
  }

  void changeRateStatus(double rate, context) {
    driverRate = rate;
    if (rate <= 1) {
      rateStatus = "Very Bad";
      rateStatusColor = ColorManager.red;
    } else if (rate > 1 && rate <= 2) {
      rateStatus = "Bad";
      rateStatusColor = Colors.redAccent;
    } else if (rate > 2 && rate <= 3) {
      rateStatus = "Good";
      rateStatusColor = Colors.greenAccent;
    } else if (rate > 3 && rate <= 4) {
      rateStatus = "Very Good";
      rateStatusColor = Colors.lightGreen;
    } else {
      rateStatus = "Excellent";
      rateStatusColor = ColorManager.green;
    }
    emit(ChangeRateStatusState());
  }

  void checkCurrentTrip(BuildContext c) async {
    if (currentTripData != null) {
      rideRequestId = currentTripData;
      listenToTheRideRequest();
      allRideRequestsSubscription =
          allRideRequestsRef!.onValue.listen((event) async {
        if (event.snapshot.value == null) {
          return;
        }
        if ((event.snapshot.value as Map)['driver_id'] != null) {
          driverId = (event.snapshot.value as Map)['driver_id'].toString();
          emit(FetchDriverDataState());
        }
        pickUpLocation = LatLng(
            double.parse(
                (event.snapshot.value as Map)['origin_lat'].toString()),
            double.parse(
                (event.snapshot.value as Map)['origin_lng'].toString()));
        addPickUpMarker(pickUpLocation!);
        pickUpAddress =
            (event.snapshot.value as Map)['origin_address'].toString();
        dropOffLocation = LatLng(
            double.parse(
                (event.snapshot.value as Map)['destination_lat'].toString()),
            double.parse(
                (event.snapshot.value as Map)['destination_lng'].toString()));
        addDropOffMarker(dropOffLocation!);
        dropOffAddress =
            (event.snapshot.value as Map)['destination_address'].toString();
        getDirectionDetailsInfo(
            localPickUpLocation: pickUpLocation!,
            localDropOffLocation: dropOffLocation!);
        getRoute();
        await retrieveOnlineDriversInfo().then((value) {
          assignedDriver =
              driversList.firstWhere((element) => element.id == driverId);
        });
        fareAmount = double.parse(
            (event.snapshot.value as Map)['fare_amount'].toString());
        emit(FetchDriverDataState());
      });

      allRideRequestsRef!.child("driver_location").onValue.listen((event) {
        if ((event.snapshot.value) != null) {
          double driverLocationLatitude = double.parse(
              (event.snapshot.value as Map)['latitude'].toString());
          double driverLocationLongitude = double.parse(
              (event.snapshot.value as Map)['longitude'].toString());
          driverLocation =
              LatLng(driverLocationLatitude, driverLocationLongitude);
          if (tStatus == 'accepted') {
            updateToPickUp(driverLocation!);
          }
          if (tStatus == "onTrip") {
            updateToDropOff(driverLocation!);
          }
          emit(FetchDriverLocationState());
        }
      });

      allRideRequestsRef!.child("trip_status").onValue.listen((event) async {
        String status = event.snapshot.value.toString();
        if (status == 'accepted') {
          updateToPickUp(driverLocation!);
        }
        if (status == 'onTrip') {
          updateToDropOff(driverLocation!);
        }
        if (status == 'arrived') {
          onTripState();
        }
        if (status == "ended") {
          endTripState(c);
        }
        if (status == 'Cancelled by driver') {
          cancelTripState(context: c);
          emit(CancelRideState());
        }
        emit(GetAvailableDriversSuccessState());
      });
    }
  }

  Future<void> addNewRequest(
      RequestDetailsInfoResponse requestDetailsInfoResponse) async {
    emit(LoadingState());
    (
        await saveRideRequestUsecase.execute(requestDetailsInfoResponse))
        .fold((l) => {
            emit(ErrorState(l)),
    }, (r) => {
          rideRequestId = r,
      emit(GetAvailableDriversSuccessState())
        });
  }

  Future<void> listenToTheRideRequest() async {
    (await listenToRideRequestUseCase
        .execute(rideRequestId!)
        ).fold((l) => {
          emit(ErrorState(l)),
    }, (r) => {allRideRequestsRef = r});
  }

  void saveRideRequestInfo(BuildContext context) async {
    BuildContext c = context;
    tripStatus = "Waiting";
    tStatus = tripStatus;
    driverId = "Waiting";
    fareAmount = calculateFare(percent: selectedVehicle == 'Car' ? 2 : 1);
    RequestDetailsInfoResponse requestDetailsInfoResponse = RequestDetailsInfoResponse(
      userId: FirebaseAuth.instance.currentUser!.uid,
      originAddress: pickUpAddress!,
      originLat: pickUpLocation!.latitude,
      originLng: pickUpLocation!.longitude,
      driverId: driverId,
      userName: myData!.name,
      userPhone: myData!.phone,
      destinationAddress: dropOffAddress!,
      destinationLat: dropOffLocation!.latitude,
      destinationLng: dropOffLocation!.longitude,
      tripStatus: tripStatus,
      date: DateTime.now().toString(),
      fareAmount: fareAmount!,
    );
        await addNewRequest(requestDetailsInfoResponse).then((value) async {
        await listenToTheRideRequest();
    });

    allRideRequestsSubscription = allRideRequestsRef!.onValue.listen((event) {
      if (event.snapshot.value == null) {
        return;
      }
      if ((event.snapshot.value as Map)['driver_id'] != null) {
        driverId = (event.snapshot.value as Map)['driver_id'].toString();
        emit(FetchDriverDataState());
      }
    });

    allRideRequestsRef!.child("driver_location").onValue.listen((event) {
      if ((event.snapshot.value) != null) {
        double driverLocationLatitude = double.parse((event.snapshot.value as Map)['latitude'].toString());
        double driverLocationLongitude = double.parse((event.snapshot.value as Map)['longitude'].toString());
        driverLocation = LatLng(driverLocationLatitude, driverLocationLongitude);
        if (tStatus == 'accepted') {
          updateToPickUp(driverLocation!);
        }
        if (tStatus == "onTrip") {
          updateToDropOff(driverLocation!);
        }


        emit(FetchDriverLocationState());
      }
    });

    allRideRequestsRef!.child("trip_status").onValue.listen((event) {
      String status = event.snapshot.value.toString();
      if (status == 'accepted') {
        tStatus = status;
        updateToPickUp(driverLocation!);
        SharedPref.saveTripData(value: rideRequestId!);
        getAssignedDriver();
        acceptedDriverModalBottomSheet(c, assignedDriver!);
      }
      if (status == 'onTrip') {
        updateToDropOff(driverLocation!);
      }
      if (status == 'arrived') {
        onTripState();
      }
      if (status == "ended") {
        endTripState(c);
      }
      if (status == 'Cancelled by driver') {
        cancelTripState(context: c);
      }
      emit(GetAvailableDriversSuccessState());
    });


    searchNearestDriver(c);
    emit(SaveRideRequestInfoState());
  }

  void searchNearestDriver(context) async {
    if (onlineDrivers.isEmpty) {
      allRideRequestsRef!.remove();
      return;
    }
    await retrieveOnlineDriversInfo().then((value) {
      for (int i = 0; i < onlineDrivers.length; i++) {
        if (driversList[i].vehicle!.type == selectedVehicle) {
          NotificationHandler.sendNotificationToDriver(driversList[i].token!,
              allRideRequestsRef!.key!, pickUpAddress!, context);
        }
      }
    });
  }

  List<AssignedDriver> driversList = [];

  Future<void> retrieveOnlineDriversInfo() async {
    emit(LoadingState());
    final result = await getAssignedDriverUsecase.execute(onlineDrivers);
    result.fold((error) {
      emit(ErrorState(error));
    }, (data) {
      driversList = data;
      emit(GetAvailableDriversSuccessState());
    });
  }

  void updateToPickUp(LatLng driverCurrentLocation) async {
    tStatus = 'accepted';
    await getDirectionDetailsInfo(
            localPickUpLocation: driverCurrentLocation,
            localDropOffLocation: pickUpLocation)
        .then((value) {
      tripStatus = 'Driver is coming in ${directionDetailsInfo!.durationText}';
    });

    emit(GetAvailableDriversSuccessState());
  }

  void updateToDropOff(
    LatLng driverCurrentLocation,
  ) async {
    tStatus = 'onTrip';
    await getDirectionDetailsInfo(
        localPickUpLocation: driverCurrentLocation,
        localDropOffLocation: dropOffLocation);

    tripStatus =
        'Driver is going to drop off in ${directionDetailsInfo!.durationText}';
    emit(GetAvailableDriversSuccessState());
  }

  void onTripState() {
    tStatus = 'arrived';
    tripStatus = "Driver has arrived";
    emit(OnTripState());
  }

  void endTripState(BuildContext c) {
    endTrip(c);
  }

  void cancelTripState({required BuildContext context}) {
    SharedPref.removeTripData();
    tStatus = 'Cancelled';
    tripStatus = "Trip Cancelled by driver";
    cancelRideByDriver();
    cancelledTripDialog(context: context);

    emit(CancelRideState());
  }

  void addPickUpMarker(LatLng location) {
    markers.remove(const Marker(markerId: MarkerId('pickUp')));
    markers.add(Marker(
      markerId: const MarkerId('pickUp'),
      position: location,
      infoWindow: const InfoWindow(title: 'Pick Up Here'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));

    circles.remove(const Circle(circleId: CircleId('pickUp')));
    circles.add(Circle(
      circleId: const CircleId('pickUp'),
      fillColor: Colors.greenAccent,
      strokeColor: Colors.greenAccent,
      center: location,
      radius: 12,
    ));

    emit(AddMarkerState());
  }

  void addDropOffMarker(LatLng location) {
    markers.remove(const Marker(markerId: MarkerId('dropOff')));
    markers.add(Marker(
      markerId: const MarkerId('dropOff'),
      position: location,
      infoWindow: const InfoWindow(title: 'Drop Off Here'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));

    circles.remove(const Circle(circleId: CircleId('dropOff')));
    circles.add(Circle(
      circleId: const CircleId('dropOff'),
      fillColor: Colors.blueAccent,
      strokeColor: Colors.blueAccent,
      center: location,
      radius: 12,
    ));

    emit(AddMarkerState());
  }

  void animateCamera(LatLng location) {
    controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 18,
        ),
      ),
    );
  }

  void getMyCurrentLocation(context) async {
    pickUpLocation = LatLng(currentLocationData!.latitude!, currentLocationData!.longitude!);
    addPickUpMarker(pickUpLocation!);
    getFormattedAddress(context);
    animateCamera(pickUpLocation!);
    if (dropOffLocation != null) {
      getRoute();
    }
    emit(GetAddressState());
  }

  Future<void> getFormattedAddress(context) async {
    emit(LoadingState());
    (await getFormattedAddressUsecase.execute(LatLng(
      pickUpLocation!.latitude,
      pickUpLocation!.longitude,
    )))
        .fold((l) {
          emit(ErrorState(l));
    }, (r) {
      pickUpAddress = r;
    });
    emit(GetAddressState());
  }

  // By selecting location on map manually
  void updatePickUpLocation(LatLng location) async {
    pickUpLocation = location;
    addPickUpMarker(pickUpLocation!);
    //await getFormattedAddress();
    if(dropOffLocation != null) {
      getDirectionDetailsInfo(
          localPickUpLocation: pickUpLocation,
          localDropOffLocation: dropOffLocation);
    }
    animateCamera(pickUpLocation!);
    if (dropOffLocation != null) {
      getRoute();
    }
    emit(UpdatePickUpLocationState());
  }

  void placeAutocomplete({required String query}) async {
    emit(GetPredictionsLoadingState());
    (await getPredictionsUsecase.execute(query))
        .fold((l) => {
          emit(ErrorState(l))
    }, (r) => {predictions = r.predictions!});
    emit(GetPredictionsSuccessState());
  }

  Future<void> updateDropSearchLocation(
      {required String placeID, required PickTypes type}) async {
    emit(LoadingState());
    (await getPlaceDetailsUsecase.execute(placeID)).fold(
        (l) => {
            emit(ErrorState(l)),
        },
        (r) => {
              if (type == PickTypes.up)
                {
                  updatePickUpLocation(LatLng(r.lat, r.lng)),
                }
              else
                {
                  dropOffLocation = LatLng(r.lat, r.lng),
                  defaultLatLng = LatLng(r.lat, r.lng),
                  dropOffAddress = r.fullAddress,
                  getDirectionDetailsInfo(
                      localPickUpLocation: pickUpLocation!,
                      localDropOffLocation: dropOffLocation!),
                  addDropOffMarker(dropOffLocation!),
                }
            });
    if (dropOffLocation != null) {
      getRoute();
    }
    emit(UpdateDropOffLocationState());
  }

  void getRoute() async {
    polyLines.clear();
    PolylinePoints polyLinePoints = PolylinePoints();
    List<LatLng> polyLineCoordinates = [];
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      AppConstants.apiKey,
      PointLatLng(pickUpLocation!.latitude, pickUpLocation!.longitude),
      PointLatLng(dropOffLocation!.latitude, dropOffLocation!.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    polyLines.add(Polyline(
      polylineId: const PolylineId('polyLineId'),
      color: Colors.blue,
      points: polyLineCoordinates,
      width: 5,
    ));
    emit(GetRouteSuccessState());
  }

  // get the direction details info
  Future<void> getDirectionDetailsInfo({
    required LatLng? localPickUpLocation,
    required LatLng? localDropOffLocation,
  }) async {
    emit(LoadingState());
    (await getDirectionDetailsInfoUsecase.execute(
            DirectionDetailsInfoUsecaseParams(
                origin: localPickUpLocation!,
                destination: localDropOffLocation!)))
        .fold((l) {
            emit(ErrorState(l));
    }, (r) {
      directionDetailsInfo = r;
      emit(GetAvailableDriversSuccessState());
    });
  }

  Future<void> initializeGeoFireListener() async {
    Geofire.initialize("activeDrivers");
    Geofire.queryAtLocation(
      pickUpLocation!.latitude,
      pickUpLocation!.longitude,
      100000000,
    )!
        .listen((map) {
      if (map != null) {
        var callBack = map['callBack'];
        switch (callBack) {
          case Geofire.onKeyEntered:
            ActiveNearbyDriver activeNearbyDriver = ActiveNearbyDriver(
              id: map['key'],
              lat: map['latitude'],
              lng: map['longitude'],
            );
            GeoFireGetNearbyDriversEventHelper.activeDrivers
                .add(activeNearbyDriver);
            onlineDrivers = GeoFireGetNearbyDriversEventHelper.activeDrivers;
            displayDriverOnMap();
            emit(GetPredictionsSuccessState());
            break;
          case Geofire.onKeyExited:
            GeoFireGetNearbyDriversEventHelper.deleteOfflineDriver(map['key']);
            removeSpecificDriverFromMap(map['key']);
            onlineDrivers = GeoFireGetNearbyDriversEventHelper.activeDrivers;
            displayDriverOnMap();
            emit(GetPredictionsSuccessState());
            break;
          case Geofire.onKeyMoved:
            GeoFireGetNearbyDriversEventHelper.updateDriverNearbyLocation(
                map['key'], LatLng(map['latitude'], map['longitude']));
            onlineDrivers = GeoFireGetNearbyDriversEventHelper.activeDrivers;
            displayDriverOnMap();
            emit(GetPredictionsSuccessState());
            break;
          case Geofire.onGeoQueryReady:
            onlineDrivers = GeoFireGetNearbyDriversEventHelper.activeDrivers;
            isDriversLoaded = true;
            displayDriverOnMap();
            break;
        }
      }
    });
    emit(InitializeGeoFireListenerState());
  }

  Future displayDriverOnMap() async {
    //ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: Size(2,2));
    for (int i = 0; i < onlineDrivers.length; i++) {
      markers.add(Marker(
        markerId: MarkerId(onlineDrivers[i].id),
        position: LatLng(onlineDrivers[i].lat, onlineDrivers[i].lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
  }

  void removeSpecificDriverFromMap(String driverId) {
    markers.removeWhere((element) => element.markerId.value == driverId);
    emit(GetPredictionsSuccessState());
  }

  double calculateFare({required int percent}) {
    // check for free trips
    if (freeTripsCount > 0) {
      freeTripsCount = freeTripsCount - 1;
      fareAmount = 0.0;
      return 0.0;
    } else {
      double timeTraveledFare = (directionDetailsInfo!.durationValue / 60) * 0.20;
      double distanceTraveledFare = (directionDetailsInfo!.distanceValue / 1000) * 0.20;
      double totalFareAmount = timeTraveledFare + distanceTraveledFare;
      double totalFareAmountWithPercent = totalFareAmount + (totalFareAmount * percent / 100);
      fareAmount = totalFareAmountWithPercent;

        // check for discount
        if (myData!.discounts.isNotEmpty) {
          double discount = double.parse(myData!.discounts[0]!);
          double discountAmount = totalFareAmountWithPercent * (discount / 100);
          fareAmount = totalFareAmountWithPercent - discountAmount;
          myData!.discounts.removeAt(0);
        }
      return totalFareAmountWithPercent;
    }
  }

  void cancelRideByUser() async {
    SharedPref.removeTripData();
    await cancelTripUsecase.execute(rideRequestId!);
    rideRequestId = "";
    driverId = 'Waiting';
    tripStatus = '';
    tStatus = '';
    tripStatus = '';
    assignedDriver = null;
    fareAmount = 0.0;

    emit(CancelRideState());
  }

  void cancelRideByDriver() async {
    SharedPref.removeTripData();
    rideRequestId = "";
    driverId = 'Waiting';
    tripStatus = '';
    tStatus = '';
    tripStatus = '';
    assignedDriver = null;
    fareAmount = 0.0;

    emit(CancelRideState());
  }

  void endTrip(BuildContext c) {
    SharedPref.removeTripData();
    tempAssignedDriver = assignedDriver;
    assignedDriver = null;
    tempRideRequestId = rideRequestId;
    rideRequestId = "";
    driverId = 'Waiting';
    tStatus = "ended";
    tripStatus = "Trip Ended";
    showFareDialog(context: c, fareAmount: fareAmount!);
    directionDetailsInfo = null;
    dropOffLocation = null;
    polyLines.clear();
    markers.clear();
    circles.clear();
    addPickUpMarker(pickUpLocation!);
    incrementUserTripsCount();
    if(freeTripsCount == 0) {
      incrementUserTripsCount();
    }
    emit(EndTripSuccessState());
    getUserData();
  }

  List<MapType> mapTypes = [
    MapType.normal,
    MapType.satellite,
  ];

  MapType selectedMapType = MapType.normal;

  void changeMapType() {
    if (selectedMapType == MapType.normal) {
      selectedMapType = MapType.satellite;
    } else {
      selectedMapType = MapType.normal;
    }
    emit(ChangeMapTypeState());
  }
}
