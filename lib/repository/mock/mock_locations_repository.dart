import 'package:w4_blabla/model/ride/locations.dart';
import 'package:w4_blabla/repository/locations_repository.dart';

class MockLocationsRepository extends LocationsRepository {
  @override
  List<Location> getLocations() {
    return [
      // mock location data
      Location(name: 'Phnom Penh', country: Country.cambodia),
      Location(name: 'Siem Reap', country: Country.cambodia),
      Location(name: 'Battambang', country: Country.cambodia),
      Location(name: 'Sihanoukville', country: Country.cambodia),
      Location(name: 'Kampot', country: Country.cambodia),
    ];
  }
}
