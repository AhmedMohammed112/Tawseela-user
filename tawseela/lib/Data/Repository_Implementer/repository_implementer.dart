import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tawseela/Data/Mappers/mappers.dart';
import 'package:tawseela/Data/Network/error_handler.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Data/Response/request_details_info_response.dart';
import 'package:tawseela/Domain/Models/active_nearby_drivers.dart';
import 'package:tawseela/Domain/Models/direction_details_info.dart';
import 'package:tawseela/Domain/Models/driver_model.dart';
import 'package:tawseela/Domain/Models/place_autocomplete_response_model.dart';
import 'package:tawseela/Domain/Models/place_details_model.dart';
import 'package:tawseela/Domain/Models/promo_code.dart';
import 'package:tawseela/Domain/Models/request_details-info.dart';
import 'package:tawseela/Domain/Models/user_model.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/get_direction_info_usecase.dart';
import 'package:tawseela/Domain/Usecases/login_usecase.dart';
import 'package:tawseela/Domain/Usecases/rate_driver_usecase.dart';
import 'package:tawseela/Domain/Usecases/register_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_promo_code_usecase.dart';
import 'package:tawseela/Data/Remote_Data_Source/remote_data_source.dart';
import '../Network/connection_checker.dart';

class RepositoryImplementer extends Repository {
  final RemoteDataSource _remoteDataSource;
  final ConnectionCheckerImpl _connectionCheckerImpl;

  RepositoryImplementer(this._remoteDataSource, this._connectionCheckerImpl);

  @override
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      RegisterUseCaseInput data) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.createUserWithEmailAndPassword(data);
        if (result.userCredential != null) {
          return Right(result.userCredential!);
        } else {
          return Left(Failure(message: result.message));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      LoginUseCaseInput data) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.signInWithEmailAndPassword(data);
        if (result.userCredential != null) {
          return Right(result.userCredential!);
        } else {
          return Left(Failure(message: result.message));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(String email) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.resetPassword(email);
        if (result != null) {
          return Right(result);
        } else {
          return Left(Failure(message: "Error"));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUserData(String uid) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getCurrentUserData(uid);
        if (result != null) {
          return Right(result.toDomain());
        } else {
          return Left(Failure(message: "Error"));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        await _remoteDataSource.logout();
        return Right("OK");
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveRideRequestInfo(
      RequestDetailsInfoResponse requestDetails) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result =
            await _remoteDataSource.saveRideRequestInfo(requestDetails);
        if (result == "OK") {
          return Right(result);
        } else {
          return Left(Failure(message: result));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<RequestDetailsInfo>>>
      getRideRequestsInfo() async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getRideRequestInfo();
        if (result.isNotEmpty) {
          return right(result.map((e) => e.toDomain()).toList());
        } else {
          return Left(Failure(message: "No Requests"));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateCurrentUserData(
      RegisterUseCaseInput data) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.updateCurrentUserData(data);
        if (result == "OK") {
          return Right(result);
        } else {
          return Left(Failure(message: result));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> rateDriver(RateDriverUseCaseInput data) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.rateDriver(data);
        return right(result);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<PromoCode>>> getPromoCodes() async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getPromoCodes();
        if (result.isNotEmpty) {
          return right(result.map((e) => e.toDomain()).toList());
        } else {
          return Left(Failure(message: "No Promo Codes"));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> getPromoCode(
      GetPromoCodeUsecaseData data) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getPromoCode(data);
        return right(result);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateUserTripsCount() async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.updateUserTripsCount();
        return right(result);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateUserFreeTripsCount() async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.updateUserFreeTripsCount();
        return right(result);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> cancelTrip(String rideRequestId) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.cancelTrip(rideRequestId);
        return right(result);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<AssignedDriver>>> getActiveDriversData(
      List<ActiveNearbyDriver> activeDrivers) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result =
            await _remoteDataSource.getActiveDriversData(activeDrivers);
        if (result.isNotEmpty) {
          return right(result.map((e) => e.toDomain()).toList());
        } else {
          return Left(Failure(message: "No Drivers"));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addRideRequest(
      RequestDetailsInfoResponse requestDetails) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.saveRideRequest(requestDetails);
        if (result.isNotEmpty) {
          return Right(result);
        } else {
          return Left(Failure(message: result));
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, DatabaseReference>> listenToRideRequest(String rideRequestId) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = _remoteDataSource.listenToRideRequest(rideRequestId);
        return Right(result);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getFormattedAddress(
      double lat, double lng) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getFormattedAddress(lat, lng);
        if (result.statusCode == ResponseCode.SUCCESS) {
          return Right(result.formattedAddress);
        } else {
          return Left(ErrorHandler.handle(result.statusCode!).failure);
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e.toString()).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, PlaceAutocomplete>> getPredictions(
      String query) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getPlaceAutocomplete(query);
        if (result.statusCode == ResponseCode.SUCCESS) {
          return Right(result.toDomain());
        } else {
          return Left(ErrorHandler.handle(result.statusCode!).failure);
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e.toString()).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, PlaceDetails>> getPlaceDetails(String placeId) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getPlaceDetails(placeId);
        if (result.statusCode == ResponseCode.SUCCESS) {
          return Right(result.toDomain());
        } else {
          return Left(ErrorHandler.handle(result.statusCode!).failure);
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e.toString()).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, DirectionDetailsInfo>> getDirectionDetails(
      DirectionDetailsInfoUsecaseParams params) async {
    if (await _connectionCheckerImpl.hasConnection) {
      try {
        final result = await _remoteDataSource.getDirectionDetails(params);
        if (result.statusCode == ResponseCode.SUCCESS) {
          return Right(result.toDomain());
        } else {
          return Left(ErrorHandler.handle(result.statusCode!).failure);
        }
      } catch (e) {
        return Left(ErrorHandler.handle(e.toString()).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET.getFailure());
    }
  }
}
