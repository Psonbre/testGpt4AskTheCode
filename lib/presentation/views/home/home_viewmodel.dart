import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/station.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/usecases/get_location_usecase.dart';
import 'package:revolvair/domain/usecases/get_station_usecase.dart';
import 'package:revolvair/presentation/app/app.router.dart';
import 'package:revolvair/presentation/app/app_setup.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:geolocator/geolocator.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final getStationUseCase = locator<GetStationUseCase>();
  final getLocationUseCase = locator<GetLocationUseCase>();

  Position? currentPos;

  bool _showPosition = true;
  bool _locationServiceEnabled = true;
  bool _isCenterChanged = false;

  final String _errorMessageTemplateStation =
      'Impossible d\'afficher les stations';
  final String _errorMessageTemplateLocalisation =
      'La localisation doit être activée';

  List<Station> stations = [];

  bool get locationServiceEnabled => _locationServiceEnabled;
  bool get showPosition => _showPosition;
  bool get isCenterChanged => _isCenterChanged;

  navigateToScaleViewPage() async {
    await _navigationService.navigateTo(Routes.scaleView);
  }

  navigateToLoginPage() async {
    await _navigationService.navigateTo(Routes.loginView);
  }

  disablePosition() {
    _showPosition = false;
    _isCenterChanged = false;
    notifyListeners();
  }

  enablePosition() async {
    await _determinePosition();
    _showPosition = true;
    _isCenterChanged = true;
    notifyListeners();
  }

  Future<void> initialize() async {
    await fetchAllStations();
    await _determinePosition();
  }

  Future<void> fetchAllStations() async {
    setBusy(true);
    Result<List<Station>, Failure> result = await getStationUseCase.execute();

    result.when(
      (success) => stations = success,
      (error) async {
        await dialogService.showDialog(
            title: 'Erreur',
            description: _errorMessageTemplateStation,
            buttonTitle: 'OK');
      },
    );
    setBusy(false);
  }

  Future<void> _determinePosition() async {
    setBusy(true);
    Result<Position, Failure> result = await getLocationUseCase.execute();

    result.when(
      (succes) => {_locationServiceEnabled = true, currentPos = succes},
      (error) async {
        await dialogService.showDialog(
            title: 'Erreur',
            description: _errorMessageTemplateLocalisation,
            buttonTitle: 'OK');
        _locationServiceEnabled = false;
        notifyListeners();
      },
    );
    setBusy(false);
  }

  void requestLocationPermission() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _locationServiceEnabled = true;
      await _determinePosition();
      _showPosition = true;
      notifyListeners();
    }
  }
}
