import 'package:w4_blabla/model/ride/locations.dart';
import 'package:w4_blabla/repository/locations_repository.dart';


////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  // static private instance
  static LocationsService? _instance;

  // access to location
  final LocationsRepository repository;

  /// Private constructor
  LocationsService._internal(this.repository);

  // static const List<Location> availableLocations = fakeLocations;

  List<Location> get availableLocations => repository.getLocations();

  ///
  /// Initialize
  ///
  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("LocationsService is already initialized.");
    }
  }

  ///
  /// Singleton accessor, getter method
  ///
  static LocationsService get instance {
    if (_instance == null) {
		  throw Exception("LocationsService is not initialized. Call initialize() first.");
		}
		return _instance!;
  }


}
