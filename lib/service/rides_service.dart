import 'package:w4_blabla/model/ride_pref/ride_pref.dart';
import 'package:w4_blabla/repository/rides_repository.dart';

import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  // static private instance
  static RidesService? _instance;

  final RidesRepository repository;

  // private constructor
  RidesService._internal(this.repository);

  ///
  /// Initialize
  ///
  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  ///
  /// Singleton accessor
  ///
  static RidesService get instance {
    if (_instance == null) {
      throw Exception(
          "RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  ///
  ///  Return the relevant rides , given the passenger preferences
  ///
  List<Ride> getRidesFor(RidePreference preferences, RidesFilter? filter, RideSortType? sortType) {
    
    List<Ride> matchingRides = repository
        .getRides(preferences, filter)
        .where((ride) =>
            ride.departureLocation == preferences.departure &&
            ride.arrivalLocation == preferences.arrival &&
            (filter == null || ride.ridesFilter.acceptPets == filter.acceptPets))
        .toList();

    // handle storing type if it's provided
    if (sortType != null) {
      switch (sortType) {
        case RideSortType.earliestDeparture:
          matchingRides
              .sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.lowestPrice:
          matchingRides
              .sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
          break;
      }
    }

    return matchingRides;
  }

  // static List<Ride> availableRides = fakeRides;

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  // static List<Ride> getRidesFor(RidePreference preferences) {
  //   // For now, just a test
  //   return availableRides.where( (ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival).toList();
  // }
}

class RidesFilter {
  final bool acceptPets;

  RidesFilter({required this.acceptPets});
}

enum RideSortType { earliestDeparture, lowestPrice }
