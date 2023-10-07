import 'package:revolvair/domain/entities/range.dart';
import 'package:revolvair/presentation/app/app.router.dart';
import 'package:revolvair/presentation/app/app_setup.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RangeTabViewModel extends BaseViewModel {
  final List<Range> ranges;
  final _navigationService = locator<NavigationService>();

  RangeTabViewModel({required this.ranges});

  navigateToRangeInfoPage(Range range, String url) async {
    await _navigationService.navigateTo(Routes.rangeInfoView,
        arguments: RangeInfoViewArguments(range: range, sourceUrl: url));
  }
}
