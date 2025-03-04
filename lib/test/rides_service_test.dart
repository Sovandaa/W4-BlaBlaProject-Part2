// import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:w4_blabla/model/ride/locations.dart';
import 'package:w4_blabla/model/ride/ride.dart';
import 'package:w4_blabla/model/ride_pref/ride_pref.dart';
import 'package:w4_blabla/repository/mock/mock_ride_preferences_repository.dart';
import 'package:w4_blabla/repository/mock/mock_rides_repository.dart';
import 'package:w4_blabla/service/ride_prefs_service.dart';
import 'package:w4_blabla/service/rides_service.dart';
import 'package:w4_blabla/utils/date_time_util.dart';

void main() {
  // Initialize the servie with mock data
  RidePrefService.initialize(MockRidePreferencesRepository());
  RidesService.initialize(MockRidesRepository());

  print("\nTest T1: ");
  test1();

  print("\n\nTest T2: ");
  test2();

  print('\n');
}

void test1() {
  // create ride pref
  RidePreference pref = RidePreference(
      departure: Location(name: 'Battambang', country: Country.cambodia),
      arrival: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now(),
      requestedSeats: 1);

  List<Ride> matchRides = RidesService.instance
      .getRidesFor(pref, RidesFilter(acceptPets: false), null);

  // check and count full rides
  int fullRide = matchRides.where((ride) => ride.availableSeats == 0).length;

  // display results
  print(
      "For your preference (${pref.departure.name} -> ${pref.arrival.name}, ${DateTimeUtils.formatDateTime(pref.departureDate)} ${pref.requestedSeats} passenger) we found ${matchRides.length} rides:");

  for (Ride ride in matchRides) {
    // String formattedTime = DateTimeUtils.formatDateTime(ride.departureDate);
    String formattedTime = DateFormat('h:mm a').format(ride.departureDate);
    int durationHours =
        ride.arrivalDateTime.difference(ride.departureDate).inHours;

    print(
        "- at $formattedTime \t with ${ride.driver.firstName} \t ($durationHours hours)");
  }
  if (fullRide > 0) {
    print("Warning: $fullRide Ride is Full!");
  }
}

void test2() {
  // create ride pref
  RidePreference pref = RidePreference(
      departure: Location(name: 'Battambang', country: Country.cambodia),
      arrival: Location(name: 'Siem Reap', country: Country.cambodia),
      departureDate: DateTime.now(),
      requestedSeats: 1);

  List<Ride> matchRides = RidesService.instance
      .getRidesFor(pref, RidesFilter(acceptPets: true), null);

  // display results
  print(
      "For your preference (${pref.departure.name} -> ${pref.arrival.name}, ${DateTimeUtils.formatDateTime(pref.departureDate)} ${pref.requestedSeats} passenger) we found ${matchRides.length} rides:");

  for (Ride ride in matchRides) {
    String formattedTime = DateFormat('h:mm a').format(ride.departureDate);
    int durationHours = ride.arrivalDateTime
        .difference(ride.departureDate)
        .inHours; // ✅ Calculate duration

    print(
        "- at $formattedTime \t with ${ride.driver.firstName} \t ($durationHours hours)");

    // check and give warnig if ride is full
    if (ride.availableSeats == 0) {
      print("Warning: Ride is Full!");
    }
  }
}
