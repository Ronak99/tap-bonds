import 'package:equatable/equatable.dart';

abstract class CompanyListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCompanyListEvent extends CompanyListEvent {}

class SearchCompaniesEvent extends CompanyListEvent {
  final String query;

  SearchCompaniesEvent(this.query);

  @override
  List<Object?> get props => [query];
}
