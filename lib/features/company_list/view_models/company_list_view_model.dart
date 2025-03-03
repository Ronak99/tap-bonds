// lib/features/company_list/viewmodels/company_list_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_event.dart';
import '../bloc/company_list_bloc.dart';

class CompanyListViewModel {
  final BuildContext context;
  final TextEditingController searchController = TextEditingController();

  CompanyListViewModel(this.context) {
    searchController.addListener(_onSearchChanged);

    _fetchCompanies();
  }

  void _onSearchChanged() {
    context
        .read<CompanyListBloc>()
        .add(SearchCompaniesEvent(searchController.text));
  }

  void _fetchCompanies() {
    context.read<CompanyListBloc>().add(FetchCompanyListEvent());
  }

  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
  }
}
