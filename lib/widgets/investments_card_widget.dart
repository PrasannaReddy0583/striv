import 'package:flutter/material.dart';
import 'package:striv/entites/investments_entites.dart';
import 'package:striv/pages/investor/investor_home_page.dart';
import 'package:striv/utils/app_palette.dart';

class InvestmentsCardWidget extends StatelessWidget {
  final InvestmentsEntites investments;
  const InvestmentsCardWidget({super.key, required this.investments});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(right: scale(context, 16)),
      padding: EdgeInsets.all(scale(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(scale(context, 16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: scale(context, 12),
            offset: Offset(0, scale(context, 6)),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: scale(context, 56),
                height: scale(context, 56),
                decoration: BoxDecoration(
                  color: AppColors.softElev,
                  borderRadius: BorderRadius.circular(scale(context, 10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://via.placeholder.com/64'),
                  ),
                ),
              ),
              SizedBox(width: scale(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      investments.title,
                      style: TextStyle(
                        fontSize: scale(context, 16),
                        fontWeight: FontWeight.w700,
                        color: AppColors.titleText,
                      ),
                    ),
                    SizedBox(height: scale(context, 4)),
                    Text(
                      investments.subtitle,
                      style: TextStyle(
                        fontSize: scale(context, 12),
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: scale(context, 14)),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Funding Progress',
                  style: TextStyle(
                    fontSize: scale(context, 13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleText,
                  ),
                ),
              ),
              Text(
                'Goal Reached',
                style: TextStyle(
                  fontSize: scale(context, 12),
                  color: AppColors.mutedText,
                ),
              ),
            ],
          ),

          SizedBox(height: scale(context, 8)),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(scale(context, 10)),
                  child: LinearProgressIndicator(
                    value: investments.progress,
                    minHeight: scale(context, 10),
                    backgroundColor: AppColors.progressBg,
                    valueColor: AlwaysStoppedAnimation(AppColors.progressFill),
                  ),
                ),
              ),
              SizedBox(width: scale(context, 12)),
              Text(
                '${(investments.progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: scale(context, 13),
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleText,
                ),
              ),
            ],
          ),

          SizedBox(height: scale(context, 14)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatColumn(
                number: investments.investors.toString(),
                label: 'Investors',
              ),
              StatColumn(
                number: investments.views.toString(),
                label: 'Pitch Views',
              ),
              StatColumn(
                number: investments.feedback.toString(),
                label: 'Feedback',
              ),
            ],
          ),

          SizedBox(height: scale(context, 16)),

          SizedBox(
            width: double.infinity,
            height: scale(context, 44),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(scale(context, 12)),
                ),
                elevation: 0,
              ),
              child: Text(
                'View Pitch Analytics',
                style: TextStyle(
                  fontSize: scale(context, 15),
                  fontWeight: FontWeight.w600,
                  color: AppPalette.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatColumn extends StatelessWidget {
  final String number;
  final String label;
  const StatColumn({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.titleText,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: AppColors.mutedText)),
      ],
    );
  }
}
