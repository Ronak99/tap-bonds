import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_bonds/core/models/company.dart';
import 'package:tap_bonds/core/services/api_service.dart';

import './company_list_event.dart';
import './company_list_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvent, CompanyListState> {
  final ApiService apiService;
  List<Company> _allCompanies = [];

  CompanyListBloc({required this.apiService}) : super(CompanListInitial()) {
    on<FetchCompanyListEvent>(_onFetchCompanies);
    on<SearchCompaniesEvent>(_onSearchCompanies);
  }

  Future<void> _onFetchCompanies(
    FetchCompanyListEvent event,
    Emitter<CompanyListState> emit,
  ) async {
    emit(CompanyListLoading());
    try {
      final companies = await apiService.getCompanies();
      _allCompanies = companies;
      emit(CompanyListLoaded(companies));
    } catch (e) {
      emit(CompanyListError(e.toString()));
    }
  }

  void _onSearchCompanies(
    SearchCompaniesEvent event,
    Emitter<CompanyListState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(CompanyListLoaded(_allCompanies));
      return;
    }

    final searchTerms = event.query.toLowerCase().trim().split(' ');

    final filteredCompanies = _allCompanies.where((company) {
      return searchTerms.any((term) {
        return company.companyName.toLowerCase().contains(term) ||
            company.isin.toLowerCase().contains(term) ||
            company.tags.any((tag) => tag.toLowerCase().contains(term));
      });
    }).toList();

    emit(CompanySearchResult(filteredCompanies, searchTerms));
  }
}
