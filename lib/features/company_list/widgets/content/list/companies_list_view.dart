import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_bonds/core/models/company.dart';
import 'package:tap_bonds/core/services/api_service.dart';
import 'package:tap_bonds/features/company_details/bloc/company_detail_bloc.dart';
import 'package:tap_bonds/features/company_details/company_detail_screen.dart';
import 'package:tap_bonds/features/company_list/widgets/content/list/company_list_item.dart';
import 'package:tap_bonds/locator.dart';

class CompaniesListView extends StatelessWidget {
  final List<Company> companies;
  final List<String>? searchTerms;
  const CompaniesListView({
    super.key,
    required this.companies,
    this.searchTerms,
  });

  @override
  Widget build(BuildContext context) {
    if (companies.isEmpty) {
      return const Center(
        child: Text('No companies found.'),
      );
    }

    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        final bool isFirst = index == 0;
        final bool isLast = index == companies.length - 1;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => {
            HapticFeedback.mediumImpact(),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CompanyDetailBloc(
                    apiService: locator<ApiService>(),
                  ),
                  child: const CompanyDetailScreen(),
                ),
              ),
            ),
          },
          child: CompanyListItem(
            company: company,
            isFirst: isFirst,
            isLast: isLast,
            searchTerms: searchTerms,
          ),
        );
      },
    );
  }
}
