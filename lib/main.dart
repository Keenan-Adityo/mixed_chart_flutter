import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<SalesData> _chartData;
  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        SfCartesianChart(
            legend: const Legend(isVisible: true),
            primaryXAxis: const CategoryAxis(title: AxisTitle(text: 'Bulan')),
            primaryYAxis: const NumericAxis(title: AxisTitle(text: 'Sales')),
            zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enableDoubleTapZooming: true,
                enableSelectionZooming: true,
                selectionRectBorderColor: Colors.red,
                selectionRectBorderWidth: 2,
                selectionRectColor: Colors.grey,
                enablePanning: true,
                zoomMode: ZoomMode.x,
                enableMouseWheelZooming: true,
                maximumZoomLevel: 0.7),
            series: <CartesianSeries>[
              ColumnSeries<SalesData, String>(
                  pointColorMapper: (datum, index) {
                    if (datum.sales >= datum.profit) {
                      return Colors.green;
                    } else {
                      return Colors.red;
                    }
                  },
                  name: 'Realisasi',
                  dataSource: _chartData,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                  ),
                  enableTooltip: true,
                  xValueMapper: (SalesData sales, _) => sales.salesMonth,
                  yValueMapper: (SalesData sales, _) => sales.sales),
              LineSeries<SalesData, String>(
                name: 'Target',
                dataSource: _chartData,
                xValueMapper: (SalesData sales, _) => sales.salesMonth,
                yValueMapper: (SalesData sales, _) => sales.profit,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ),
                enableTooltip: true,
              ),
            ]),
        const Text("Lanjot"),
      ],
    )));
  }

  List<SalesData> getChartData() {
    return <SalesData>[
      SalesData('Jan', 35, 15),
      SalesData('Feb', 28, 17),
      SalesData('Mar', 34, 50),
      SalesData('Apr', 32, 22),
      SalesData('May', 40, 45)
    ];
  }
}

class SalesData {
  SalesData(this.salesMonth, this.sales, this.profit);
  final String salesMonth;
  final double sales;
  final double profit;
}
