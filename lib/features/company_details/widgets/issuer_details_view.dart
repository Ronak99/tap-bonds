import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_bonds/core/models/company_detail/company_detail.dart';
import 'package:tap_bonds/shared/widgets/content_container.dart';

class IssuerDetailsView extends StatelessWidget {
  final CompanyDetail company;
  const IssuerDetailsView({super.key, required this.company});

  Widget _buildIssuerDetailRow(String label, String value,
      {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
      child: SizedBox(
        height: 45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xff1D4ED8),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xff111827),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xffE2E8F0),
                ),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/AddressBook.svg',
                  height: 18,
                  width: 18,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Issuer Details',
                  style: TextStyle(
                    color: Color(0xff020617),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .2,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIssuerDetailRow(
                    'Issuer Name', company.issuerDetails.issuerName),
                _buildIssuerDetailRow(
                    'Type', company.issuerDetails.typeOfIssuer),
                _buildIssuerDetailRow('Sector', company.issuerDetails.sector),
                _buildIssuerDetailRow(
                    'Industry', company.issuerDetails.industry),
                _buildIssuerDetailRow(
                    'Nature', company.issuerDetails.issuerNature),
                _buildIssuerDetailRow('CIN', company.issuerDetails.cin),
                _buildIssuerDetailRow(
                    'Lead Manager', company.issuerDetails.leadManager),
                _buildIssuerDetailRow(
                    'Registrar', company.issuerDetails.registrar),
                _buildIssuerDetailRow(
                  'Debenture Trustee',
                  company.issuerDetails.debentureTrustee,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
