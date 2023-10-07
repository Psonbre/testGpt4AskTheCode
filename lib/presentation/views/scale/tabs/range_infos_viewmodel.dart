import 'package:revolvair/domain/entities/range.dart';
import 'package:revolvair/presentation/app/app_setup.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class RangeInfosViewModel extends BaseViewModel {
  final Range range;
  final String sourceUrl;
  final _navigationService = locator<NavigationService>();

  RangeInfosViewModel({required this.range, required this.sourceUrl});

  navigateToScaleView() {
    _navigationService.back();
  }

  launchURL() async {
    Uri url = Uri.parse(sourceUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
