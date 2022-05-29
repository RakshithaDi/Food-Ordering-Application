import 'package:charts_flutter/flutter.dart' as charts;

class Item {
  late String name;
  late int voteCount;
  final charts.Color barColor;

  Item({required this.name, required this.voteCount, required this.barColor});
}
