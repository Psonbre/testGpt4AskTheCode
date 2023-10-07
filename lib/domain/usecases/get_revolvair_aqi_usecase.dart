import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/ranges.dart';
import 'package:revolvair/domain/failures/failure.dart';
import 'package:revolvair/domain/services/ranges_service.dart';
import 'package:revolvair/domain/usecases/AQI.dart';

class GetRangesUseCase {
  final RangesService rangesService;

  GetRangesUseCase({required this.rangesService});

  Future<Result<Ranges, Failure>> execute(AQI type) {
    switch (type) {
      case AQI.revolvair:
        return rangesService.getRevolvairAirQualityRanges();
      case AQI.aqhi:
        return rangesService.getAquiAirQualityRanges();
      case AQI.usepa:
        return rangesService.getUsepaAirQualityRanges();
    }
  }
}
