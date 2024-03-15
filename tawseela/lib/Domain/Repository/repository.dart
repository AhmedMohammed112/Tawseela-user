import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Data/Response/request_details_info_response.dart';
import 'package:tawseela/Domain/Models/direction_details_info.dart';
import 'package:tawseela/Domain/Models/driver_model.dart';
import 'package:tawseela/Domain/Models/place_autocomplete_response_model.dart';
import 'package:tawseela/Domain/Models/place_details_model.dart';
import 'package:tawseela/Domain/Models/user_model.dart';
import 'package:tawseela/Domain/Usecases/get_direction_info_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_promo_code_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_promo_codes_usecase.dart';
import 'package:tawseela/Domain/Usecases/register_usecase.dart';
import '../Models/active_nearby_drivers.dart';
import '../Models/promo_code.dart';
import '../Models/request_details-info.dart';
import '../Usecases/login_usecase.dart';
import '../Usecases/rate_driver_usecase.dart';

abstract class Repository
{
  Future<Either<Failure,UserCredential>> createUserWithEmailAndPassword(RegisterUseCaseInput data);
  Future<Either<Failure,UserCredential>> signInWithEmailAndPassword(LoginUseCaseInput data);
  Future<Either<Failure,String>> resetPassword(String email);
  Future<Either<Failure,UserModel>> getCurrentUserData(String uid);
  Future<Either<Failure,List<AssignedDriver>>> getActiveDriversData(List<ActiveNearbyDriver> activeDrivers);
  Future<Either<Failure,String>> updateCurrentUserData(RegisterUseCaseInput data);
  Future<Either<Failure,void>> logout();
  Future<Either<Failure,String>> saveRideRequestInfo(RequestDetailsInfoResponse requestDetails);
  Future<Either<Failure,List<RequestDetailsInfo>>> getRideRequestsInfo();
  Future<Either<Failure,void>> rateDriver(RateDriverUseCaseInput data);
  Future<Either<Failure,List<PromoCode>>> getPromoCodes();
  Future<Either<Failure,void>> getPromoCode(GetPromoCodeUsecaseData data);
  Future<Either<Failure,void>> updateUserTripsCount();
  Future<Either<Failure,void>> updateUserFreeTripsCount();
  Future<Either<Failure,void>> cancelTrip(String rideRequestId);
  Future<Either<Failure,String>> addRideRequest(RequestDetailsInfoResponse requestDetails);
  Future<Either<Failure,DatabaseReference>> listenToRideRequest(String rideRequestId); // returns the ride request reference

  Future<Either<Failure,String>> getFormattedAddress(double lat, double lng);
  Future<Either<Failure,PlaceAutocomplete>> getPredictions(String query);
Future<Either<Failure,PlaceDetails>> getPlaceDetails(String placeId);
Future<Either<Failure,DirectionDetailsInfo>> getDirectionDetails(DirectionDetailsInfoUsecaseParams params);
}