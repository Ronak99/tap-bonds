import 'package:tap_bonds/core/models/company_detail.dart';

abstract class CompanyDetailState {}

class CompanyDetailInitial extends CompanyDetailState {}

class CompanyDetailLoading extends CompanyDetailState {}

class CompanyDetailLoaded extends CompanyDetailState {
  final CompanyDetail companyDetail;

  CompanyDetailLoaded(this.companyDetail);
}

class CompanyDetailError extends CompanyDetailState {
  final String message;

  CompanyDetailError(this.message);
}
