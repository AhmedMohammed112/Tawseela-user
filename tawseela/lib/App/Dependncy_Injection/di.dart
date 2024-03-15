import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tawseela/Data/Remote_Data_Source/remote_data_source.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/forgot_password_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_assigned_driver_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_direction_info_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_formatted-address_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_predictions_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_promo_codes_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_ride_requests_usecase.dart';
import 'package:tawseela/Domain/Usecases/login_usecase.dart';
import 'package:tawseela/Domain/Usecases/register_usecase.dart';
import 'package:tawseela/Domain/Usecases/save_ride_request_info_usecase.dart';
import 'package:tawseela/Domain/Usecases/update_user_data_usecase.dart';
import 'package:tawseela/Presentation/Screens/Forgot_Password_Screen/Forgot_Password_Cubit/forgot_password_cubit.dart';
import 'package:tawseela/Presentation/Screens/Login_Screen/Login_Cubit/login_cubit.dart';
import 'package:tawseela/Presentation/Screens/Register_Screen/Register_Cubit/register_cubit.dart';

import 'package:tawseela/Data/App_Service_Client/app_api.dart';
import 'package:tawseela/Data/Repository_Implementer/repository_implementer.dart';
import 'package:tawseela/Domain/Usecases/cancel_trip_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_place_details_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_promo_code_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_user_data_usecase.dart';
import 'package:tawseela/Domain/Usecases/log_out_usecase.dart';
import 'package:tawseela/Domain/Usecases/rate_driver_usecase.dart';
import 'package:tawseela/Domain/Usecases/update_user_free_trips_count.dart';
import 'package:tawseela/Domain/Usecases/update_user_trips_count.dart';

import '../../Data/Network/connection_checker.dart';

var sl = GetIt.instance;

void init() async {
  sl.registerLazySingleton(() => AppServiceClientFirebaseApi());

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl<AppServiceClientFirebaseApi>()));

  sl.registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl(InternetConnectionChecker()));

  sl.registerLazySingleton<Repository>(() => RepositoryImplementer(sl<RemoteDataSource>(), ConnectionCheckerImpl(InternetConnectionChecker())));

}

void initRegister() {
  if (!sl.isRegistered<RegisterUsecase>()) {
    sl.registerFactory<RegisterUsecase>(() => RegisterUsecase(repository: sl<Repository>()));
    sl.registerFactory<RegisterCubit>(() => RegisterCubit());
  }
}


void initLogin() {
  if (!sl.isRegistered<LoginUsecase>()) {
    sl.registerFactory<LoginUsecase>(() => LoginUsecase(repository: sl<Repository>()));
    sl.registerFactory<LoginCubit>(() => LoginCubit());
  }
} 

void initForgetPassword() {
  if (!sl.isRegistered<ForgotPasswordUsecase>()) {
    sl.registerFactory<ForgotPasswordUsecase>(() => ForgotPasswordUsecase(repository: sl<Repository>()));
    sl.registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit());
  }
}

void initGetUserInfo() {
  if (!sl.isRegistered<GetCurrentUserInfoUsecase>()) {
    sl.registerFactory<GetCurrentUserInfoUsecase>(() => GetCurrentUserInfoUsecase(repository: sl<Repository>()));
  }
}

void initUpdateCurrentUserInfo() {
  if (!sl.isRegistered<UpdateCurrentUserDataUsecase>()) {
    sl.registerFactory<UpdateCurrentUserDataUsecase>(() => UpdateCurrentUserDataUsecase(repository: sl<Repository>()));
  }
}

void initLogout() {
  if (!sl.isRegistered<LogoutUsecase>()) {
    sl.registerFactory<LogoutUsecase>(() => LogoutUsecase(repository: sl<Repository>()));
  }
}

void initGetFormattedAddress() {
  if(!sl.isRegistered<GetFormattedAddressUsecase>()) {
    sl.registerFactory<GetFormattedAddressUsecase>(() => GetFormattedAddressUsecase(repository: sl<Repository>()));
  }
}

void initGetPredictions() {
  if(!sl.isRegistered<GetPredictionsUsecase>()) {
    sl.registerFactory<GetPredictionsUsecase>(() => GetPredictionsUsecase(repository: sl<Repository>()));
  }
}

void initGetPlaceDetails() {
  if(!sl.isRegistered<GetPlaceDetailsUsecase>()) {
    sl.registerFactory<GetPlaceDetailsUsecase>(() => GetPlaceDetailsUsecase(repository: sl<Repository>()));
  }
}

void initGetDirectionDetailsInfo() {
  if(!sl.isRegistered<GetDirectionDetailsInfoUsecase>()) {
    sl.registerFactory<GetDirectionDetailsInfoUsecase>(() => GetDirectionDetailsInfoUsecase(repository: sl<Repository>()));
  }
} 

void initSaveRideRequestDetailsInfo() {
  if(!sl.isRegistered<SaveRideRequestInfoUsecase>()) {
    sl.registerFactory<SaveRideRequestInfoUsecase>(() => SaveRideRequestInfoUsecase(repository: sl<Repository>()));
  }
}

void initGetRideRequestDetailsInfo() {
  if(!sl.isRegistered<GetRideRequestsUsecase>()) {
    sl.registerFactory<GetRideRequestsUsecase>(() => GetRideRequestsUsecase(repository: sl<Repository>()));
  }
}


void initGetAssignedDriverInfo() {
  if(!sl.isRegistered<GetActiveDriversUsecase>()) {
    sl.registerFactory<GetActiveDriversUsecase>(() => GetActiveDriversUsecase(repository: sl<Repository>()));
  }
}

void initRateDriver() {
  if(!sl.isRegistered<RateDriverUsecase>()) {
    sl.registerFactory<RateDriverUsecase>(() => RateDriverUsecase(repository: sl<Repository>()));
  }
}

void initGetPromoCode() {
  if(!sl.isRegistered<GetPromoCodesUsecase>()) {
    sl.registerFactory<GetPromoCodesUsecase>(() => GetPromoCodesUsecase(repository: sl<Repository>()));
  }
}

void initGetMyPromoCode() {
  if(!sl.isRegistered<GetMyPromoCodeUsecase>()) {
    sl.registerFactory<GetMyPromoCodeUsecase>(() => GetMyPromoCodeUsecase(repository: sl<Repository>()));
  }
}

void initUpdateUserTripsCount() {
  if(!sl.isRegistered<UpdateUserTripsCountUsecase>()) {
    sl.registerFactory<UpdateUserTripsCountUsecase>(() => UpdateUserTripsCountUsecase(repository: sl<Repository>()));
  }
}

void initUpdateUserFreeTripsCount() {
  if(!sl.isRegistered<UpdateUserFreeTripsCountUsecase>()) {
    sl.registerFactory<UpdateUserFreeTripsCountUsecase>(() => UpdateUserFreeTripsCountUsecase(repository: sl<Repository>()));
  }
}

void initCancelTrip() {
  if(!sl.isRegistered<CancelTripUsecase>()) {
    sl.registerFactory<CancelTripUsecase>(() => CancelTripUsecase(repository: sl<Repository>()));
  }
}

void initSaveRideRequest() {
  if(!sl.isRegistered<SaveRideRequestUsecase>()) {
    sl.registerFactory<SaveRideRequestUsecase>(() => SaveRideRequestUsecase(repository: sl<Repository>()));
  }
}

void initListenToRideRequest() {
  if(!sl.isRegistered<ListenToRideRequestUseCase>()) {
    sl.registerFactory<ListenToRideRequestUseCase>(() => ListenToRideRequestUseCase(repository: sl<Repository>()));
  }
}

