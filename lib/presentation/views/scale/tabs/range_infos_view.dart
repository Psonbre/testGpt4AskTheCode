import 'package:flutter/material.dart';
import 'package:revolvair/domain/entities/range.dart';
import 'package:revolvair/presentation/views/scale/tabs/range_info_list_tile.dart';
import 'package:revolvair/presentation/views/scale/tabs/range_infos_viewmodel.dart';
import 'package:stacked/stacked.dart';

class RangeInfoView extends StatelessWidget {
  final Range range;
  final String sourceUrl;
  const RangeInfoView({Key? key, required this.range, required this.sourceUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () =>
            RangeInfosViewModel(range: range, sourceUrl: sourceUrl),
        builder: (context, viewModel, child) => Scaffold(
            appBar: AppBar(title: const Text("Niveau de pollution")),
            body: SingleChildScrollView(
                child: Column(children: [
              RangeListTile(
                title: "Niveau de pollution",
                secondaryWidget: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(int.parse('0xFF${range.color}')),
                  ),
                ),
                thirdWidget: Text(range.label),
              ),
              RangeListTile(
                  title: "PM2.5 µg/m\u00B3",
                  secondaryWidget: Text('${range.min} à ${range.max}')),
              RangeListTile(
                  title: "Effets sur la santé",
                  secondaryWidget: Expanded(
                      child: Text(range.healthEffect, softWrap: true))),
              RangeListTile(
                  title: "Mise en garde (PM2.5)",
                  secondaryWidget: Expanded(child: Text(range.note))),
              RangeListTile(
                title: "Source",
                secondaryWidget: IconButton(
                    icon: const Icon(
                      Icons.open_in_new,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      viewModel.launchURL();
                    }),
                thirdWidget: Text(Uri.parse(sourceUrl).host),
              )
            ]))));
  }
}
