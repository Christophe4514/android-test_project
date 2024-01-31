import 'package:dashboard/chart/line_chart.dart';
import 'package:dashboard/chart_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FL Chart Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'FL Chart Tutorial'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Cons Jours", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 25
                    ),),
                    Text("Cons Mois", style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        fontSize: 25
                    ),)
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.all(4),
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.width * 0.95 * 0.65,
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _LineChart(),
                ),
                /*ListView(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    children: <Widget>[
                      ChartContainer(
                        title: 'Line Chart',
                        color: Colors.purple,
                        chart: LineChartContent(
                        ),
                      ),
                    ],
                  ),*/
              ),
            ],
          ),
        ));
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: LineChart(
        duration: const Duration(microseconds: 500),
        sampleData1,
      ),
    );
  }
}

LineChartData get sampleData1 => LineChartData(
    gridData: gridData,
    titlesData: titlesData,
    borderData: boarderData,
    lineBarsData: lineBarsData,
    minX: 0,
    maxX: 14,
    minY: 1,
    maxY: 4);

List<LineChartBarData> get lineBarsData =>
    [lineChartBarData1, lineChartBarData2];

FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ));

Widget leftTitlesWidget(double value, TitleMeta meta) {
  const style =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.blue);
  String text;
  switch (value.toInt()) {
    case 1:
      text = "1 kwh";
    case 2:
      text = "2 kwh";
    case 3:
      text = "3 kwh";
    case 4:
      text = "4 kwh";
    case 5:
      text = "5 kwh";
      break;
    default:
      return Container();
  }
  return Text(
    text,
    style: style,
    textAlign: TextAlign.center,
  );
}

SideTitles leftTitles() => const SideTitles(
    getTitlesWidget: leftTitlesWidget,
    showTitles: true,
    interval: 1,
    reservedSize: 40);

Widget bottomTitleWidget(double value, TitleMeta meta) {
  const style =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.red);
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text(
        'Lun',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Mar',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Mer',
        style: style,
      );
      break;
    case 7:
      text = const Text(
        'jeu',
        style: style,
      );
      break;
    case 9:
      text = const Text(
        'Ven',
        style: style,
      );
      break;
    case 11:
      text = const Text(
        'Sam',
        style: style,
      );
      break;
    case 13:
      text = const Text(
        'Dim',
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: text,
  );
}

SideTitles get bottomTitles => const SideTitles(
      showTitles: true,
      reservedSize: 32,
      interval: 1,
      getTitlesWidget: bottomTitleWidget,
    );

FlGridData get gridData => const FlGridData(show: false);

FlBorderData get boarderData => FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(color: Colors.grey, width: 4),
        left: BorderSide(color: Colors.grey),
        right: BorderSide(color: Colors.transparent),
        top: BorderSide(color: Colors.transparent),
      ),
    );

LineChartBarData get lineChartBarData1 => LineChartBarData(
        isCurved: true,
        color: Colors.white,
        barWidth: 6,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0.3, 1),
          FlSpot(3, 2.4),
          FlSpot(4, 1.8),
          FlSpot(6, 3),
          FlSpot(7, 2.5),
          FlSpot(9, 1.7),
          FlSpot(12, 3.5),
        ]);

LineChartBarData get lineChartBarData2 => LineChartBarData(
        isCurved: true,
        color: Colors.red,
        barWidth: 6,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 1),
          FlSpot(3, 2.9),
          FlSpot(4, 1.3),
          FlSpot(7, 3),
          FlSpot(8, 2.6),
          FlSpot(11, 1.5),
          FlSpot(12, 2.1),
        ]);

/*
List<FlSpot> spots = [];
int index = 0;
var consommations_jour = {"consommations_jour": {
  "Friday": "1226424",
  "Monday": "142544",
  "Saturday": "10384",
  "Sunday": "14632",
  "Thursday": "86376",
  "Tuesday": "86413"
}};
data['consommations_jour'].forEach((key, value) {
double x = index.toDouble();
double y = double.parse(value);

FlSpot spot = FlSpot(x, y);
spots.add(spot);

index++;
});*/
