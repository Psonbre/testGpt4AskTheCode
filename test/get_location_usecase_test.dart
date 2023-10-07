import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';

class MockGeoLocator extends Mock implements Geolocator {
}

void main() async {
  late MockGeoLocator mockGeoLocator;

  setUp(() {
    mockGeoLocator = MockGeoLocator();
  });

  group('Tests de locations', () {
    test('Retourne une position avec succes', () => 
    prints('hello')
    );
  });
}
