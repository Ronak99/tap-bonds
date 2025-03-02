import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_bonds/core/models/company_detail.dart';
import 'package:tap_bonds/shared/widgets/content_container.dart';

class ProsAndConsView extends StatelessWidget {
  final CompanyDetail company;
  const ProsAndConsView({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Pros and Cons',
              style: TextStyle(
                color: Color(0xff020617),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Pros",
                style: TextStyle(
                  color: Color(0xff15803D),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: company.prosAndCons.pros
                    .map(
                      (pro) => Container(
                        margin: EdgeInsets.only(
                          bottom: company.prosAndCons.pros.indexOf(pro) ==
                                  company.prosAndCons.pros.length - 1
                              ? 0
                              : 24,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xff16a34a).withOpacity(.12),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset('assets/Check.svg'),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Text(
                                pro,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(
                                    0xff364153,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 32),
              const Text(
                "Cons",
                style: TextStyle(
                  color: Color(0xffB45309),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: company.prosAndCons.cons
                    .map(
                      (con) => Container(
                        margin: EdgeInsets.only(
                          bottom: company.prosAndCons.cons.indexOf(con) ==
                                  company.prosAndCons.cons.length - 1
                              ? 0
                              : 24,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 18,
                              width: 18,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xffD97706).withOpacity(.12),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                  'assets/ExclamationMark.svg'),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              con,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Color(
                                  0xff64748B,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
