import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_detail.freezed.dart';
part 'company_detail.g.dart';

@freezed
class CompanyDetail with _$CompanyDetail {
  const factory CompanyDetail({
    required String logo,
    @JsonKey(name: 'company_name') required String companyName,
    required String description,
    required String isin,
    required String status,
    @JsonKey(name: 'pros_and_cons') required ProsAndCons prosAndCons,
    required Financials financials,
    @JsonKey(name: 'issuer_details') required IssuerDetails issuerDetails,
  }) = _CompanyDetail;

  factory CompanyDetail.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetailFromJson(json);
}

@freezed
class ProsAndCons with _$ProsAndCons {
  const factory ProsAndCons({
    required List<String> pros,
    required List<String> cons,
  }) = _ProsAndCons;

  factory ProsAndCons.fromJson(Map<String, dynamic> json) =>
      _$ProsAndConsFromJson(json);
}

@freezed
class Financials with _$Financials {
  const factory Financials({
    required List<FinancialData> ebitda,
    required List<FinancialData> revenue,
  }) = _Financials;

  factory Financials.fromJson(Map<String, dynamic> json) =>
      _$FinancialsFromJson(json);
}

@freezed
class FinancialData with _$FinancialData {
  const factory FinancialData({
    required String month,
    required int value,
  }) = _FinancialData;

  factory FinancialData.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataFromJson(json);
}

@freezed
class IssuerDetails with _$IssuerDetails {
  const factory IssuerDetails({
    @JsonKey(name: 'issuer_name') required String issuerName,
    @JsonKey(name: 'type_of_issuer') required String typeOfIssuer,
    @JsonKey(name: 'sector') required String sector,
    @JsonKey(name: 'industry') required String industry,
    @JsonKey(name: 'issuer_nature') required String issuerNature,
    required String cin,
    @JsonKey(name: 'lead_manager') required String leadManager,
    required String registrar,
    @JsonKey(name: 'debenture_trustee') required String debentureTrustee,
  }) = _IssuerDetails;

  factory IssuerDetails.fromJson(Map<String, dynamic> json) =>
      _$IssuerDetailsFromJson(json);
}
