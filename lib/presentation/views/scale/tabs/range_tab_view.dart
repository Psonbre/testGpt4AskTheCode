import 'package:flutter/material.dart';
import 'package:revolvair/domain/entities/ranges.dart';
import 'package:revolvair/presentation/views/scale/tabs/range_card.dart';
import 'package:revolvair/presentation/views/scale/tabs/range_tab_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RangeTabView extends StatelessWidget {
  final Ranges ranges;

  const RangeTabView({required this.ranges, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => RangeTabViewModel(ranges: ranges.ranges),
        builder: (context, viewModel, child) => Scaffold(
                body: Scrollbar(
              child: ListView.builder(
                  itemCount: ranges.ranges.length,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => viewModel.navigateToRangeInfoPage(ranges.ranges[index], ranges.url),
                        child: RangeCard(range: ranges.ranges[index]),
                      )),
            )));
  }
}
