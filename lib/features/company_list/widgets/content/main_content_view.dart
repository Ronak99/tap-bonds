import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_bloc.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_state.dart';
import 'package:tap_bonds/features/company_list/widgets/content/list/companies_list_view.dart';
import 'package:tap_bonds/shared/widgets/loading_indicator.dart';

class MainContentView extends StatelessWidget {
  const MainContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyListBloc, CompanyListState>(
      builder: (context, state) {
        // Show a loading indicator when loading.
        if (state is CompanyListLoading) {
          return const LoadingIndicator();
        }

        // Render everything within a Flex.
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dynamic text based on the state.
              Container(
                margin: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  state is CompanySearchResult
                      ? 'Search Results'.toUpperCase()
                      : 'Suggested Results'.toUpperCase(),
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

              // Expanded for ListView.
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (state is CompanyListLoaded) {
                      return CompaniesListView(companies: state.companies);
                    }
                    if (state is CompanySearchResult) {
                      return CompaniesListView(
                        companies: state.companies,
                        searchTerms: state.searchTerms,
                      );
                    }
                    if (state is CompanyListError) {
                      Center(child: Text(state.message));
                    }
                    return const Text("No companies found.");
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
