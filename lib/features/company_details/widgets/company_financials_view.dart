import 'package:flutter/material.dart';
import 'package:tap_bonds/core/enums/graph_view.dart';
import 'package:tap_bonds/core/models/company_detail.dart';
import 'package:tap_bonds/features/company_details/widgets/charts/revenue_ebitda_chart.dart';
import 'package:tap_bonds/shared/widgets/content_container.dart';

class CompanyFinancialsView extends StatefulWidget {
  final Financials financials;
  const CompanyFinancialsView({super.key, required this.financials});

  @override
  State<CompanyFinancialsView> createState() => _CompanyFinancialsViewState();
}

class _CompanyFinancialsViewState extends State<CompanyFinancialsView> {
  GraphView _selectedGraphView = GraphView.ebitda;

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      borderRadius: BorderRadius.circular(12),
      shadow: [
        BoxShadow(
          blurRadius: 6,
          offset: const Offset(0, 2),
          spreadRadius: -1,
          color: Colors.black.withOpacity(.06),
        )
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Company Financials'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    letterSpacing: 1,
                    color: Color(0xffA3A3A3),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: .4,
                      color: const Color(0xffe5e5e5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                        color: const Color(0xff525866).withOpacity(.06),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(999),
                  ),
                  height: 25,
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      CustomTab(
                        selectedGraphView: _selectedGraphView,
                        tabGraphView: GraphView.ebitda,
                        onTap: () {
                          setState(() {
                            _selectedGraphView = GraphView.ebitda;
                          });
                        },
                      ),
                      CustomTab(
                        selectedGraphView: _selectedGraphView,
                        tabGraphView: GraphView.revenue,
                        onTap: () {
                          setState(() {
                            _selectedGraphView = GraphView.revenue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Graph
          SizedBox(
            height: 180,
            child: RevenueEbitdaChart(
              financials: widget.financials,
              graphView: _selectedGraphView,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final VoidCallback onTap;
  final GraphView selectedGraphView;
  final GraphView tabGraphView;
  const CustomTab({
    super.key,
    required this.onTap,
    required this.selectedGraphView,
    required this.tabGraphView,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedGraphView == tabGraphView;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          top: 3,
          right: 6,
          left: 8,
          bottom: 3,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: selectedGraphView == GraphView.ebitda
                ? const Radius.circular(999)
                : const Radius.circular(0),
            right: selectedGraphView == GraphView.revenue
                ? const Radius.circular(999)
                : const Radius.circular(0),
          ),
          border: Border.all(
            color: isSelected ? const Color(0xffe5e5e5) : Colors.transparent,
            width: .4,
          ),
        ),
        child: Text(
          tabGraphView == GraphView.ebitda ? 'EBITDA' : 'Revenue',
          style: TextStyle(
            color:
                isSelected ? const Color(0xff171717) : const Color(0xff737373),
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
