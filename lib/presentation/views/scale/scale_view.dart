import 'package:flutter/material.dart';
import 'package:revolvair/presentation/views/scale/scale_viewmodel.dart';
import 'package:revolvair/presentation/views/scale/tabs/range_tab_view.dart';

import 'package:stacked/stacked.dart';

class ScaleView extends StatefulWidget {
  const ScaleView({Key? key}) : super(key: key);

  @override
  _ScaleViewState createState() => _ScaleViewState();
}

class _ScaleViewState extends State<ScaleView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ScaleViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) {
        return viewModel.isBusy
            ? const Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Échelles de qualité de l\'air'),
                    bottom: const TabBar(tabs: [
                      Text('Revolvair'),
                      Text('AQHI-Canada'),
                      Text('IQA EPA US')
                    ]),
                  ),
                  body: TabBarView(
                    children: [
                      RangeTabView(ranges: viewModel.revolvairRanges),
                      RangeTabView(ranges: viewModel.aqhiRanges),
                      RangeTabView(ranges: viewModel.usepaRanges)
                    ],
                  ),
                ),
              );
      },
    );
  }
}
