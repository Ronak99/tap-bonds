import 'package:tap_bonds/core/models/company.dart';

abstract class CompanyListState {}

class CompanListInitial extends CompanyListState {}

class CompanyListLoading extends CompanyListState {}

class CompanyListLoaded extends CompanyListState {
  final List<Company> companies;

  CompanyListLoaded(this.companies);
}

class CompanyListError extends CompanyListState {
  final String message;

  CompanyListError(this.message);
}
