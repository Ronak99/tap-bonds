import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_bonds/core/services/api_service.dart';

import './company_list_event.dart';
import './company_list_state.dart';

class CompanyListBloc extends Bloc<CompanyListEvent, CompanyListState> {
  final ApiService apiService;

  CompanyListBloc({required this.apiService}) : super(CompanListInitial()) {
    on<FetchCompanyListEvent>(_onFetchCompanies);
  }

  Future<void> _onFetchCompanies(
    FetchCompanyListEvent event,
    Emitter<CompanyListState> emit,
  ) async {
    emit(CompanyListLoading());
    try {
      final companies = await apiService.getCompanies();
      emit(CompanyListLoaded(companies));
    } catch (e) {
      emit(CompanyListError(e.toString()));
    }
  }
}
