import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_bonds/core/services/api_service.dart';

import './company_detail_event.dart';
import './company_detail_state.dart';

class CompanyDetailBloc extends Bloc<CompanyDetailEvent, CompanyDetailState> {
  final ApiService apiService;

  CompanyDetailBloc({required this.apiService})
      : super(CompanyDetailInitial()) {
    on<FetchCompanyDetailEvent>(_onFetchCompanies);
  }

  Future<void> _onFetchCompanies(
    FetchCompanyDetailEvent event,
    Emitter<CompanyDetailState> emit,
  ) async {
    emit(CompanyDetailLoading());
    try {
      final companies = await apiService.getCompanyDetail();
      emit(CompanyDetailLoaded(companies));
    } catch (e) {
      emit(CompanyDetailError(e.toString()));
    }
  }
}
