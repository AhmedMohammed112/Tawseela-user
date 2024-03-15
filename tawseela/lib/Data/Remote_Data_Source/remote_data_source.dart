import 'package:firebase_database/firebase_database.dart';
import 'package:tawseela/Data/App_Service_Client/app_api.dart';
import 'package:tawseela/Data/Response/current_user_info-response.dart';
import 'package:tawseela/Data/Response/request_details_info_response.dart';
import 'package:tawseela/Domain/Models/active_nearby_drivers.dart';
import 'package:tawseela/Domain/Usecases/get_direction_info_usecase.dart';
import 'package:tawseela/Domain/Usecases/register_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_promo_code_usecase.dart';
import 'package:tawseela/Domain/Usecases/login_usecase.dart';
import 'package:tawseela/Domain/Usecases/rate_driver_usecase.dart';
import 'package:tawseela/Data/Response/direction_details_info_response.dart';
import 'package:tawseela/Data/Response/driver_response.dart';
import 'package:tawseela/Data/Response/formated_address_response.dart';
import 'package:tawseela/Data/Response/place_autocomplete_response.dart';
import 'package:tawseela/Data/Response/place_details_response.dart';
import 'package:tawseela/Data/Response/promo_code_response.dart';
import 'package:tawseela/Data/Response/authentication_response.dart';

abstract class RemoteDataSource
{
    Future<AuthenticationResponse> createUserWithEmailAndPassword(RegisterUseCaseInput data);
    Future<AuthenticationResponse> signInWithEmailAndPassword(LoginUseCaseInput data);
    Future<String> resetPassword(String email);
    Future<CurrentUserDataResponse> getCurrentUserData(String uid);
    Future<List<AssignedDriverResponse>> getActiveDriversData(List<ActiveNearbyDriver> activeDrivers);
    Future<String> updateCurrentUserData(RegisterUseCaseInput data);
    Future<void> logout();
    Future<String> saveRideRequestInfo(RequestDetailsInfoResponse requestDetails);
    Future<List<RequestDetailsInfoResponse>> getRideRequestInfo();
    Future<void> rateDriver(RateDriverUseCaseInput data);
    Future<List<PromoCodeResponse>> getPromoCodes();
    Future<void> getPromoCode(GetPromoCodeUsecaseData data);
    Future<void> updateUserTripsCount();
    Future<void> updateUserFreeTripsCount();
    Future<void> cancelTrip(String rideRequestId);
    Future<String> saveRideRequest(RequestDetailsInfoResponse request);
    DatabaseReference listenToRideRequest(String rideRequestId);

    Future<FormattedAddressResponse> getFormattedAddress(double lat, double lng);
    Future<PlaceAutocompleteResponse> getPlaceAutocomplete(String query);
    Future<PlaceDetailsResponse> getPlaceDetails(String placeId);
    Future<DirectionDetailsInfoResponse> getDirectionDetails(DirectionDetailsInfoUsecaseParams params);
}



class RemoteDataSourceImpl implements RemoteDataSource
{
  final AppServiceClientFirebaseApi _appServiceClientFirebaseApi;

  RemoteDataSourceImpl(this._appServiceClientFirebaseApi);

  @override
  Future<AuthenticationResponse> createUserWithEmailAndPassword(RegisterUseCaseInput data) async {
    return await _appServiceClientFirebaseApi.createUserWithEmailAndPassword(data);
  }

  @override
  Future<AuthenticationResponse> signInWithEmailAndPassword(LoginUseCaseInput data) async {
    return await _appServiceClientFirebaseApi.signInWithEmailAndPassword(data);
  }

  @override
  Future<String> resetPassword(String email) async {
    return await _appServiceClientFirebaseApi.forgotPassword(email);
  }

  @override
  Future<CurrentUserDataResponse> getCurrentUserData(String uid) async {
    return await _appServiceClientFirebaseApi.getUserData(uid);
  }

  @override
  Future<void> logout() async {
    return await _appServiceClientFirebaseApi.logout();
  }

  @override
  Future<FormattedAddressResponse> getFormattedAddress(double lat, double lng) async {
    return await _appServiceClientFirebaseApi.getFormattedAddress(lat, lng);
  }

  @override
  Future<PlaceAutocompleteResponse> getPlaceAutocomplete(String query) async {
    return await _appServiceClientFirebaseApi.getPlaceAutocomplete(query);
  }

  @override
  Future<PlaceDetailsResponse> getPlaceDetails(String placeId) async {
    return await _appServiceClientFirebaseApi.getPlaceDetails(placeId);
  }

  @override
  Future<DirectionDetailsInfoResponse> getDirectionDetails(DirectionDetailsInfoUsecaseParams params) async {
    return await _appServiceClientFirebaseApi.getDirectionDetailsInfo(params);
  }
  
  @override
  Future<String> saveRideRequestInfo(RequestDetailsInfoResponse requestDetails) async {
    return await _appServiceClientFirebaseApi.postRequestData(requestDetails);
  }

  @override
  Future<List<RequestDetailsInfoResponse>> getRideRequestInfo() async {
    return await _appServiceClientFirebaseApi.getUsersTripsHistory();
  }

  @override
  Future<String> updateCurrentUserData(RegisterUseCaseInput data) async {
    return await _appServiceClientFirebaseApi.updateUserData(data);
  }

  @override
  Future<void> rateDriver(RateDriverUseCaseInput data) async {
    return await _appServiceClientFirebaseApi.rateDriver(data);
  }

  @override
  Future<List<PromoCodeResponse>> getPromoCodes() async {
    return await _appServiceClientFirebaseApi.getPromoCodes();
  }

  @override
  Future<void> getPromoCode(GetPromoCodeUsecaseData data) async {
    return await _appServiceClientFirebaseApi.getPromoCode(data);
  }

  @override
  Future<void> updateUserTripsCount() async {
    return await _appServiceClientFirebaseApi.updateUserTripsCount();
  }

  @override
  Future<void> updateUserFreeTripsCount() async {
    return await _appServiceClientFirebaseApi.updateUserFreeTripsCount();
  }

  @override
  Future<void> cancelTrip(String rideRequestId) async {
    return await _appServiceClientFirebaseApi.cancelTrip(rideRequestId);
  }

  @override
  Future<List<AssignedDriverResponse>> getActiveDriversData(List<ActiveNearbyDriver> activeDrivers) async {
    return await _appServiceClientFirebaseApi.getActiveDriversData(activeDrivers);
  }

  @override
  Future<String> saveRideRequest(RequestDetailsInfoResponse request) async {
    return await _appServiceClientFirebaseApi.saveRideRequest(request);
  }

  @override
  DatabaseReference listenToRideRequest(String rideRequestId) {
    return _appServiceClientFirebaseApi.listenToRideRequest(rideRequestId);
  }















}