import 'package:multiple_result/multiple_result.dart';
import 'package:revolvair/domain/entities/ranges.dart';
import 'package:revolvair/domain/failures/failure.dart';

abstract class RangesService {
  Future<Result<Ranges, Failure>> getRevolvairAirQualityRanges();
  Future<Result<Ranges, Failure>> getAquiAirQualityRanges();
  Future<Result<Ranges, Failure>> getUsepaAirQualityRanges();
}
