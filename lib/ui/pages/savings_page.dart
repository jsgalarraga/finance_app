import 'package:intl/intl.dart';
import 'package:finance_app/data/model/savings_entry.dart';
import 'package:finance_app/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavingsPage extends StatelessWidget {
  SavingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SavingsEntry>>(
      stream: context.read(savingsNotifierProvider).savingsStream(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SavingsEntry>> snapshot) {
        if (snapshot.hasData) {
          List<SavingsEntry> _chartData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'My savings'),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    crosshairBehavior: CrosshairBehavior(
                      enable: true,
                      activationMode: ActivationMode.longPress,
                    ),
                    zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true,
                      enablePinching: true,
                      enableDoubleTapZooming: true,
                      maximumZoomLevel: 0.5,
                    ),
                    series: <ChartSeries>[
                      LineSeries<SavingsEntry, int>(
                        name: 'Savings',
                        dataSource: _chartData,
                        xValueMapper: (SavingsEntry savings, _) => savings.id,
                        yValueMapper: (SavingsEntry savings, _) =>
                            savings.value,
                        enableTooltip: true,
                      )
                    ],
                    primaryXAxis: NumericAxis(decimalPlaces: 0),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.currency(
                        symbol: '€',
                        decimalDigits: 0,
                      ),
                    ),
                  ),
                ),
                Text('Tap the line to view value'),
                Text('Pinch or double tap to zoom'),
                Text('Long press to enable crosshair'),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
