import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tap_bonds/features/company_list/view_models/company_list_view_model.dart';
import 'package:tap_bonds/shared/widgets/content_container.dart';

class SearchField extends StatelessWidget {
  final CompanyListViewModel viewModel;
  const SearchField({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          SvgPicture.asset('assets/MagnifyingGlass.svg'),
          const SizedBox(width: 12),
          Expanded(
            child: CupertinoTextField(
              controller: viewModel.searchController,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                  color: Colors.transparent,
                ),
              ),
              placeholder: "Search by Issuer Name or ISIN",
              placeholderStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff99A1AF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
