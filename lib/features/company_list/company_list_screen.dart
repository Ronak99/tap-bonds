import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tap_bonds/core/models/company.dart';
import 'package:tap_bonds/core/services/api_service.dart';
import 'package:tap_bonds/features/company_details/bloc/company_detail_bloc.dart';
import 'package:tap_bonds/features/company_details/company_detail_screen.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_bloc.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_event.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_state.dart';
import 'package:tap_bonds/shared/widgets/loading_indicator.dart';

import '../../shared/widgets/content_container.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyListBloc>().add(FetchCompanyListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Home',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              ContentContainer(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/MagnifyingGlass.svg'),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search by Issuer Name or ISIN",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  'Suggested Results'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    height: 1.5,
                    letterSpacing: 1.2,
                    color: Color(
                      0xff99A1AF,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ContentContainer(
                  child: BlocBuilder<CompanyListBloc, CompanyListState>(
                    builder: (context, state) {
                      if (state is CompanyListLoading) {
                        return const LoadingIndicator();
                      } else if (state is CompanyListLoaded) {
                        return _buildCompanyList(state.companies);
                      } else if (state is CompanyListError) {
                        return Center(child: Text('Error: ${state.message}'));
                      }
                      return const Center(child: Text('No companies found'));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyList(List<Company> companies) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CompanyDetailBloc(
                    apiService: Get.find<ApiService>(),
                  ),
                  child: const CompanyDetailScreen(),
                ),
              ),
            ),
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: .4,
                        color: const Color(0xffE5E7EB),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        company.logo,
                        fit: BoxFit.contain,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(company.isin),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            company.rating,
                            style: const TextStyle(
                              color: Color(0xff99A1AF),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: const Text(
                              "·",
                              style: TextStyle(
                                color: Color(0xff99A1AF),
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          Text(
                            company.companyName,
                            style: const TextStyle(
                              color: Color(0xff99A1AF),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  SvgPicture.asset('assets/CaretRight.svg')
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getRatingColor(String rating) {
    if (rating.contains('AAA')) {
      return Colors.green;
    } else if (rating.contains('AA')) {
      return Colors.lightGreen;
    } else if (rating.contains('A')) {
      return Colors.blue;
    } else if (rating.contains('BBB')) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
