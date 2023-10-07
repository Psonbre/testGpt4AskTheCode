import 'package:flutter/material.dart';
import 'package:revolvair/domain/entities/range.dart';

class RangeCard extends StatelessWidget {
  final Range range;

  RangeCard({required this.range});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse('0xFF${range.color}')),
              ),
            ),
            title: Text(range.label),
            subtitle: Text("De ${range.min} à ${range.max} " "µg/m\u00B3"),
          ),
        ],
      ),
    );
  }
}
