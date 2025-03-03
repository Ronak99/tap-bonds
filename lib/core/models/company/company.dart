import 'package:freezed_annotation/freezed_annotation.dart';

// required: associates our `main.dart` with the code generated by Freezed
part 'company.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'company.g.dart';

@freezed
abstract class Company with _$Company {
  const factory Company({
    required String logo,
    required String isin,
    required String rating,
    @JsonKey(name: 'company_name') required String companyName,
    required List<String> tags,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
