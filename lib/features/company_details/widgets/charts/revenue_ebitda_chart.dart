import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:tap_bonds/core/enums/graph_view.dart';
import 'package:tap_bonds/core/models/company_detail/company_detail.dart';
import 'package:tap_bonds/theme/colors.dart';
import 'package:tap_bonds/utils/utils.dart';

class RevenueEbitdaChart extends StatelessWidget {
  final Financials financials;
  final GraphView graphView;

  const RevenueEbitdaChart({
    super.key,
    required this.financials,
    required this.graphView,
  });

  @override
  Widget build(BuildContext context) {
    final List<FinancialData> ebitdaData = financials.ebitda;
    final List<FinancialData> revenueData = financials.revenue;

    // Calculate max value for Y axis scaling (round up to nearest 10 million)
    final double maxValue = revenueData
        .map((item) => (item.value as num).toDouble())
        .reduce((max, value) => value > max ? value : max);
    final double yAxisMax = ((maxValue / 10000000).ceil()) * 10000000;

    const double barWidth = 15;
    const double leftReservedSize = 35;
    const double horizontalPadding = 16;

    return Container(
      margin: const EdgeInsets.all(horizontalPadding),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xfffafafa),
          ),
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: yAxisMax,
                    minY: 0,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final int index = value.toInt();

                            if (index >= 0 && index < ebitdaData.length) {
                              // Use first letter of month
                              return Container(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  ebitdaData[index].month.toString()[0],
                                  style: const TextStyle(
                                    color: subtleGreyColor,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          interval: yAxisMax / 7,
                          showTitles: true,
                          reservedSize: leftReservedSize,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            if (value == 0) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  Utils.formatToINR(value),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8,
                                    letterSpacing: .2,
                                    color: Colors.transparent,
                                  ),
                                ),
                              );
                            }

                            // index of this left axis
                            final int index = (value / (yAxisMax / 7)).round();
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(
                                Utils.formatToINR(value),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                  letterSpacing: .2,
                                  color: index % 2 != 0
                                      ? Colors.transparent
                                      : subtleGreyColor,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: yAxisMax / 7,
                      verticalInterval: 0.3345,
                      getDrawingVerticalLine: (value) {
                        if (value == 0.3345) {
                          return const FlLine(
                            color: subtleGreyColor,
                            dashArray: [5],
                            strokeWidth: 0.6,
                          );
                        }
                        return const FlLine(
                          color: Colors.transparent,
                        );
                      },
                      getDrawingHorizontalLine: (value) {
                        final int index = (value / (yAxisMax / 7)).round();
                        return FlLine(
                          color: index % 2 != 0
                              ? const Color(0xfff5f5f5)
                              : subtleGreyColor,
                          strokeWidth: 0.6,
                        );
                      },
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: List.generate(
                      ebitdaData.length,
                      (index) {
                        final ebitdaValue = ebitdaData[index].value.toDouble();
                        final revenueValue =
                            revenueData[index].value.toDouble();

                        return BarChartGroupData(
                          x: index,
                          groupVertically: true,
                          barRods: [
                            BarChartRodData(
                              toY: revenueValue,
                              color: graphView == GraphView.ebitda
                                  ? const Color(0xff155DFC).withOpacity(.25)
                                  : const Color(0xff155DFC),
                              width: barWidth,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            BarChartRodData(
                              toY: ebitdaValue,
                              color: graphView == GraphView.ebitda
                                  ? const Color(0xff101828)
                                  : Colors.transparent,
                              width: barWidth,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: leftReservedSize + barWidth * 4 + ((barWidth * 3) / 2),
            top: 0,
            bottom: 20,
            child: SizedBox(
              width: barWidth * 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: const Text(
                      '2024',
                      style: TextStyle(
                        fontSize: 8,
                        color: subtleGreyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: 0,
                    decoration: BoxDecoration(
                      border: RDottedLineBorder(
                        left: const BorderSide(
                          width: .6,
                          color: subtleGreyColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: const Text(
                      '2025',
                      style: TextStyle(
                        fontSize: 8,
                        color: subtleGreyColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
