import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/ranges.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/usecases/AQI.dart';
import 'package:revolvair/domain/usecases/get_revolvair_aqi_usecase.dart';
import 'package:revolvair/presentation/app/app_setup.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ScaleViewModel extends BaseViewModel {
  final dialogService = locator<DialogService>();
  final getRangesUseCase = locator<GetRangesUseCase>();
  final String _errorMessageTemplate = 'Impossible de récupérer l\'échelle de ';

  Future<void> initialize() async {
    await fetchRevolvairData();
    await fetchAqhiData();
    await fetchUsepaData();
  }

  Ranges revolvairRanges = Ranges(name: '', source: '', url: '', ranges: []);
  Ranges aqhiRanges = Ranges(name: '', source: '', url: '', ranges: []);
  Ranges usepaRanges = Ranges(name: '', source: '', url: '', ranges: []);

  Future<void> fetchRevolvairData() async {
    setBusy(true);
    Result<Ranges, Failure> result =
        await getRangesUseCase.execute(AQI.revolvair);

    result.when(
      (success) => revolvairRanges = success,
      (error) async {
        await dialogService.showDialog(
            title: 'Erreur',
            description: '$_errorMessageTemplate Revolvair',
            buttonTitle: 'OK');
      },
    );
    setBusy(false);
  }

  Future<void> fetchAqhiData() async {
    setBusy(true);
    Result<Ranges, Failure> result = await getRangesUseCase.execute(AQI.aqhi);
    result.when(
      (success) {
        aqhiRanges = success;
      },
      (error) async {
        await dialogService.showDialog(
            title: 'Erreur',
            description: '$_errorMessageTemplate AQHI',
            buttonTitle: 'OK');
      },
    );
    setBusy(false);
  }

  Future<void> fetchUsepaData() async {
    setBusy(true);
    Result<Ranges, Failure> result = await getRangesUseCase.execute(AQI.usepa);

    result.when(
      (success) => usepaRanges = success,
      (error) async {
        await dialogService.showDialog(
            title: 'Erreur',
            description: '$_errorMessageTemplate USEPA',
            buttonTitle: 'OK');
      },
    );
    setBusy(false);
  }
}
