import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_bonds/features/company_details/bloc/company_detail_bloc.dart';
import 'package:tap_bonds/features/company_details/bloc/company_detail_event.dart';
import 'package:tap_bonds/features/company_details/bloc/company_detail_state.dart';
import 'package:tap_bonds/features/company_details/widgets/company_financials_view.dart';
import 'package:tap_bonds/features/company_details/widgets/custom_back_button.dart';
import 'package:tap_bonds/features/company_details/widgets/issuer_details_view.dart';
import 'package:tap_bonds/features/company_details/widgets/top_level_metrics.dart';
import 'package:tap_bonds/shared/widgets/loading_indicator.dart';

import 'widgets/pros_and_cons_view.dart';

class CompanyDetailScreen extends StatefulWidget {
  const CompanyDetailScreen({super.key});

  @override
  _CompanyDetailScreenState createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<CompanyDetailBloc>().add(FetchCompanyDetailEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CompanyDetailBloc, CompanyDetailState>(
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // 1. Sticky Header
                SliverAppBar(
                  leading: null,
                  leadingWidth: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xffF3F4F6),
                  titleSpacing: 0,
                  expandedHeight: 76,
                  toolbarHeight: 76,
                  title: Container(
                    height: 76,
                    width:
                        double.infinity, // Make the container take full width
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const CustomBackButton(),
                  ),
                  pinned: true,
                  floating: false,
                  forceElevated: innerBoxIsScrolled,
                  // Remove bottom padding
                  bottom: PreferredSize(
                    preferredSize: Size.zero,
                    child: Container(),
                  ),
                ),

                if (state is CompanyDetailLoading)
                  const SliverToBoxAdapter(
                    child: LoadingIndicator(),
                  ),

                // 2. Intro View
                if (state is CompanyDetailLoaded)
                  SliverToBoxAdapter(
                    child: TopLevelMetrics(
                      logo: state.companyDetail.logo,
                      name: state.companyDetail.companyName,
                      description: state.companyDetail.description,
                      isin: state.companyDetail.isin,
                    ),
                  ),

                if (state is CompanyDetailLoaded)
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        labelColor: const Color(0xff1447E6),
                        indicatorSize: TabBarIndicatorSize.label,
                        dividerHeight: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        indicatorPadding: EdgeInsets.zero,
                        labelStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelColor: const Color(0xff4A5565),
                        indicatorColor: const Color(0xff1447E6),
                        tabs: const [
                          Tab(text: 'ISIN Analysis'),
                          Tab(text: 'Pros & Cons'),
                        ],
                      ),
                    ),
                    pinned: false,
                  ),
              ];
            },

            // 4. Tab Bar Views
            body: state is CompanyDetailLoaded
                ? TabBarView(
                    controller: _tabController,
                    children: [
                      // First Tab View
                      ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          const SizedBox(height: 12),
                          const CompanyFinancialsView(),
                          const SizedBox(height: 12),
                          IssuerDetailsView(company: state.companyDetail),
                          const SizedBox(height: 16),
                        ],
                      ),

                      ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          const SizedBox(height: 12),
                          ProsAndConsView(company: state.companyDetail),
                        ],
                      ),
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => 42;

  @override
  double get maxExtent => 42;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 42,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE5E7EB),
            width: 0.5,
          ),
        ),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
