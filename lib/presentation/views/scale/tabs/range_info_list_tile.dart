import 'package:flutter/material.dart';

class RangeListTile extends StatelessWidget {
  final String title;
  final Widget secondaryWidget;
  final Widget? thirdWidget;

  RangeListTile(
      {required this.title, required this.secondaryWidget, this.thirdWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListTile(
            title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  secondaryWidget,
                  if (thirdWidget != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: thirdWidget!,
                    )
                ],
              ),
            )
          ],
        )));
  }
}
