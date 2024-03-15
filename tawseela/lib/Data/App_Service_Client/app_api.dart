import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tawseela/App/Constants/constants.dart';
import 'package:tawseela/Data/Response/current_user_info-response.dart';
import 'package:tawseela/Data/Response/formated_address_response.dart';
import 'package:tawseela/Data/Response/promo_code_response.dart';
import 'package:tawseela/Data/Response/request_details_info_response.dart';
import 'package:tawseela/Domain/Usecases/get_direction_info_usecase.dart';
import 'package:tawseela/Domain/Usecases/login_usecase.dart';
import 'package:tawseela/Domain/Usecases/register_usecase.dart';
import 'package:http/http.dart' as http;
import '../../Domain/Models/active_nearby_drivers.dart';
import '../../Domain/Usecases/get_promo_code_usecase.dart';
import '../../Domain/Usecases/rate_driver_usecase.dart';
import '../Response/authentication_response.dart';
import '../Response/direction_details_info_response.dart';
import '../Response/driver_response.dart';
import '../Response/place_autocomplete_response.dart';
import '../Response/place_details_response.dart';

class AppServiceClientFirebaseApi { 
  
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseDatabase = FirebaseDatabase.instance.ref();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();


// create user
  Future<AuthenticationResponse> createUserWithEmailAndPassword(
      RegisterUseCaseInput data) async {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(
          email: data.email, password: data.password);

      await 
          firebaseDatabase
          .child(AppConstants.usersEndPoint)
          .child(userCredential.user!.uid)
          .set(
        data.toJson(),
      );
      await firebaseDatabase
          .child(AppConstants.usersEndPoint)
          .child(userCredential.user!.uid)
          .child('id')
          .set(userCredential.user!.uid);

      return AuthenticationResponse(
          message: "Success", userCredential: userCredential);
  }

// sign in user
  Future<AuthenticationResponse> signInWithEmailAndPassword(
      LoginUseCaseInput data) async {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(
          email: data.email!, password: data.password!);
      return AuthenticationResponse(
          message: "Success", userCredential: userCredential);
  }

// forgot password
  Future<String> forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    return "Email sent";
  }

//get user data from firebase database
  Future<CurrentUserDataResponse> getUserData(String uid) async {
    DatabaseReference dataSnapshot =
    firebaseDatabase.child('users').child(uid);
    DatabaseEvent snapshot = await dataSnapshot.once();
    return CurrentUserDataResponse.fromJson(snapshot.snapshot);
  }

// logout user
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

// update user data
  Future<String> updateUserData(RegisterUseCaseInput data) async {
      await firebaseDatabase
          .child('users')
          .child(firebaseAuth.currentUser!.uid)
          .update(data.toJson()).then((value) {
                return "OK";
      }).catchError((onError) {
        return onError.toString();
      });
    return "OK";
  }

// post request data
  Future<String> postRequestData(
      RequestDetailsInfoResponse requestDetails) async {
      await firebaseDatabase
          .child(AppConstants.usersEndPoint).
      child(firebaseAuth.currentUser!.uid).
      child("ride_request").
      set(requestDetails.toJson());

      return "Success";
  }

// get all request data
  Future<List<RequestDetailsInfoResponse>> getUsersTripsHistory() async {
      final List<RequestDetailsInfoResponse> trips = [];
      return await firebaseDatabase
          .child(AppConstants.requestsEndPoint).
      orderByChild('user_id').
      equalTo(firebaseAuth.currentUser!.uid).
      once().then((snapshot) {
        if (snapshot.snapshot.value != null) {
          for (var element in snapshot.snapshot.children) {
            trips.add(RequestDetailsInfoResponse.fromJson(element));

          }
        }
        return trips;
      });
  }

// get Assigned Driver Data
  Future<List<AssignedDriverResponse>> getActiveDriversData(List<ActiveNearbyDriver> activeDrivers) async {
      final List<AssignedDriverResponse> drivers = [];
      for (var element in activeDrivers) {
        await firebaseDatabase
            .child(AppConstants.driversEndPoint).
        child(element.id).
        once().then((snapshot) {
          if (snapshot.snapshot.value != null) {
            drivers.add(AssignedDriverResponse.fromJson(snapshot.snapshot));
          }
        });
      }
      return drivers;
  }


  Future<void> rateDriver(RateDriverUseCaseInput data) async {
    await firebaseDatabase
        .child(AppConstants.driversEndPoint)
        .child(data.driverId)
        .child("review")
        .set(data.reviews);

    firebaseDatabase.child(AppConstants.requestsEndPoint).child(data.rideRequestId).child('rate').set(data.reviews[data.reviews.length - 1]['rate']);
    firebaseDatabase.child(AppConstants.driversEndPoint).child(data.driverId).child('rating').set(data.driverRate);
  }

  Future<List<PromoCodeResponse>> getPromoCodes() async {
      final List<PromoCodeResponse> promoCodes = [];
      return await firebaseDatabase
          .child(AppConstants.promoCodesEndPoint).
      once().then((snapshot) {
        if (snapshot.snapshot.value != null) {
          for (var element in snapshot.snapshot.children) {
            promoCodes.add(PromoCodeResponse.fromJson(element));
          }
        }
        return promoCodes;
      });
  }

  Future<void> getPromoCode(GetPromoCodeUsecaseData data) async {
       firebaseDatabase
        .child(AppConstants.promoCodesEndPoint)
        .child(data.promoCode)
        .child(AppConstants.usersEndPoint)
        .set(data.users);

        firebaseDatabase
        .child(AppConstants.usersEndPoint)
        .child(firebaseAuth.currentUser!.uid)
        .child("free_trips")
        .once().then((snapshot) {
          if (snapshot.snapshot.value != null) {
            int freeTrips = (snapshot.snapshot.value as int) + data.freeTrips;
            firebaseDatabase
                .child(AppConstants.usersEndPoint)
                .child(firebaseAuth.currentUser!.uid)
                .child("free_trips")
                .set(freeTrips);
          }
          else {
            firebaseDatabase
                .child(AppConstants.usersEndPoint)
                .child(firebaseAuth.currentUser!.uid)
                .child("free_trips")
                .set(data.freeTrips);
          }
       });

        firebaseDatabase
        .child(AppConstants.usersEndPoint)
        .child(firebaseAuth.currentUser!.uid)
        .child("discounts")
        .once()
        .then((snapshot) {
      if (snapshot.snapshot.value != null) {
        List<dynamic> discount = (snapshot.snapshot.value as dynamic).map((e) => e).toList();
        discount.add(data.discount);

        firebaseDatabase
            .child(AppConstants.usersEndPoint)
            .child(firebaseAuth.currentUser!.uid)
            .child("discounts")
            .set(discount);
      }
      else {
        List<dynamic> discount = [];
        discount.add(data.discount);

        firebaseDatabase
            .child(AppConstants.usersEndPoint)
            .child(firebaseAuth.currentUser!.uid)
            .child("discounts")
            .set(discount);
      }
        });
        }

  Future<void> updateUserTripsCount() async {
        firebaseDatabase.child(AppConstants.usersEndPoint).child(firebaseAuth.currentUser!.uid).child('trips').once().then((snapshot) {
          int tripsCount = int.parse(snapshot.snapshot.value.toString());
          tripsCount++;
          firebaseDatabase.child(AppConstants.usersEndPoint).child(firebaseAuth.currentUser!.uid).child('trips').set(tripsCount);
        });
      }

  Future<void> updateUserFreeTripsCount() async {
        firebaseDatabase.child(AppConstants.usersEndPoint).child(firebaseAuth.currentUser!.uid).child('free_trips').once().then((snapshot) {
          int freeTripsCount = int.parse(snapshot.snapshot.value.toString());
          freeTripsCount--;
          firebaseDatabase.child(AppConstants.usersEndPoint).child(firebaseAuth.currentUser!.uid).child('free_trips').set(freeTripsCount);
        });
      }

  Future<void> cancelTrip(String rideRequestId) async {
        // delete ride request if the driver_id is Waiting status else set the status to Cancelled by user
        firebaseDatabase.child(AppConstants.requestsEndPoint).child(rideRequestId).child('driver_id').once().then((snapshot) {
          if (snapshot.snapshot.value.toString() == 'Waiting') {
            firebaseDatabase.child(AppConstants.requestsEndPoint).child(rideRequestId).remove();
          } else {
            firebaseDatabase.child(AppConstants.requestsEndPoint).child(rideRequestId).child('trip_status').set('Cancelled by user');
          }
        });
      }

  Future<String> saveRideRequest(RequestDetailsInfoResponse request) async {
        DatabaseReference rideRequestsRef = _databaseReference.child(AppConstants.requestsEndPoint).push();
        await rideRequestsRef.set(request.toJson());
        return rideRequestsRef.key.toString();
      }

  DatabaseReference listenToRideRequest(String rideRequestId) {
        return _databaseReference.child(AppConstants.requestsEndPoint).child(rideRequestId);
      }

  // get formatted address
  Future<FormattedAddressResponse> getFormattedAddress(double latitude, double longitude) async {
      final url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${AppConstants
          .apiKey}";
      final response = await http.get(Uri.parse(url));
      return FormattedAddressResponse.fromJson(response) .. statusCode = response.statusCode .. message = response.reasonPhrase;
  }

  // get place autocomplete
  Future<PlaceAutocompleteResponse> getPlaceAutocomplete(String query) async {
    Uri uri =
    Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": AppConstants.apiKey,
    });

    final response = await http.get(uri);

    return PlaceAutocompleteResponse.parseAutocompleteResponse(response.body) .. statusCode = response.statusCode .. message = response.reasonPhrase;
  }

  // get place details
  Future<PlaceDetailsResponse> getPlaceDetails(String placeID) async {
    Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json', {
      "place_id": placeID,
      "key": AppConstants.apiKey,
    });

    final response = await http.get(uri);
    return PlaceDetailsResponse.fromJson(response.body) .. statusCode = response.statusCode .. message = response.reasonPhrase;
  }

  //get distance and time taken between two points in different modes of transport
  Future<DirectionDetailsInfoResponse> getDirectionDetailsInfo(DirectionDetailsInfoUsecaseParams params) async {
      final url = "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${params
          .destination.latitude},${params.destination
          .longitude}&origins=${params.origin.latitude},${params.origin
          .longitude}&units=imperial&key=${AppConstants.apiKey}";
      final response = await http.get(Uri.parse(url));
      return DirectionDetailsInfoResponse.fromJson(response.body) .. statusCode = response.statusCode;
  }
}