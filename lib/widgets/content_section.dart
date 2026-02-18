import 'package:flutter/material.dart';
import '../models/pitch_model.dart';

class ContentSection extends StatelessWidget {
  final PitchModel pitchModel;

  const ContentSection({super.key, required this.pitchModel});

  @override
  Widget build(BuildContext context) {
    // Switch content based on selected tab
    switch (pitchModel.selectedTabIndex) {
      case 0: // Overview
        return _buildOverviewContent(context);
      case 1: // Team
        return _buildTeamContent(context);
      case 2: // Market
        return _buildMarketContent(context);
      case 3: // Model
        return _buildModelContent(context);
      case 4: // Traction & KPI's
        return _buildTractionContent(context);
      case 5: // Funding
        return _buildFundingContent(context);
      default:
        return _buildOverviewContent(context);
    }
  }

  Widget _buildOverviewContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContentItem(
          context,
          title: 'Problem',
          content: pitchModel.problem,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        _buildContentItem(
          context,
          title: 'Solution',
          content: pitchModel.solution,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
        _buildContentItem(
          context,
          title: 'Differentiator',
          content: pitchModel.differentiator,
        ),
      ],
    );
  }

  Widget _buildTeamContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Our Team Title
        Text(
          'Our Team',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        // Team Member 1 - Jane Doe
        _buildTeamMember(
          context,
          name: 'Jane Doe',
          title: 'CEO',
          description:
              '15+ years in tech leadership, scaling startups from seed to Series C',
          avatarColor: const Color(0xFF8B4513), // Brown color for Jane
          hasVerification: true,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // Team Member 2 - John Smith
        _buildTeamMember(
          context,
          name: 'John Smith',
          title: 'CTO',
          description:
              'Expert in AI and machine learning with a PhD from a top university',
          avatarColor: const Color(0xFF2F4F4F), // Dark slate gray for John
          hasVerification: true,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.035),

        // Team Size & Structure
        Text(
          'Team Size & Structure',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Row(
          children: [
            _buildTeamStat(context, '15', 'FTEs', Icons.people_outline),
            SizedBox(width: MediaQuery.of(context).size.width * 0.08),
            _buildTeamStat(context, '5', 'Contractors', Icons.work_outline),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.035),

        // Advisors & Mentors
        Text(
          'Advisors & Mentors',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        _buildAdvisor(
          context,
          name: 'Dr. Emily Carter',
          title: 'Marketing & Growth Expert',
          hasLock: true,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        _buildAdvisor(
          context,
          name: 'Mark Chen',
          title: 'Financial Strategy Advisor',
          hasLock: false,
        ),
      ],
    );
  }

  Widget _buildTeamMember(
    BuildContext context, {
    required String name,
    required String title,
    required String description,
    required Color avatarColor,
    required bool hasVerification,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
          child: Center(
            child: Text(
              name.split(' ').map((e) => e[0]).join(''),
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.04),

        // Member Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      '$name | $title',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: MediaQuery.of(context).size.width * 0.042,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  if (hasVerification) ...[
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0AB20),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                description,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              // LinkedIn Icon
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.business_center,
                  color: Colors.grey[600],
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeamStat(
    BuildContext context,
    String count,
    String label,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey[600],
          size: MediaQuery.of(context).size.width * 0.05,
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          '$count $label',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAdvisor(
    BuildContext context, {
    required String name,
    required String title,
    required bool hasLock,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.037,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.003),
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        if (hasLock)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0AB20),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(Icons.lock, color: Colors.white, size: 14),
          ),
      ],
    );
  }

  Widget _buildMarketContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Market Opportunity Title
        Text(
          'Market Opportunity',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // Industry/Sector
        Text(
          'INDUSTRY / SECTOR',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.032,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Row(
          children: [
            _buildIndustryTag(context, 'SaaS'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            _buildIndustryTag(context, 'Fintech'),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            _buildIndustryTag(context, 'AI'),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Geography Target
        Text(
          'GEOGRAPHY TARGET',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.032,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Text(
          'Global, India, Southeast Asia',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.038,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Market Size Metrics
        Row(
          children: [
            Expanded(
              child: _buildMarketMetric(
                context,
                label: 'TAM',
                value: '\$1.2T',
                hasTooltip: true,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.08),
            Expanded(
              child: _buildMarketMetric(
                context,
                label: 'SAM',
                value: '\$300B',
                hasTooltip: true,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        Row(
          children: [
            Expanded(
              child: _buildMarketMetric(
                context,
                label: 'SOM',
                value: '\$15B',
                hasTooltip: true,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.08),
            Expanded(
              child: _buildMarketMetric(
                context,
                label: 'MARKET GROWTH',
                value: '20% CAGR',
                hasTooltip: false,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),

        // View Report Button
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening market report...',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  backgroundColor: const Color(0xFFF0AB20),
                ),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.download,
                  color: const Color(0xFFF0AB20),
                  size: MediaQuery.of(context).size.width * 0.045,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  'View Report',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: const Color(0xFFF0AB20),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),

        // Competitor Mapping
        Text(
          'Competitor Mapping',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        _buildCompetitor(
          context,
          name: 'Competitor A',
          description: 'Leading the market with a strong brand presence.',
          percentage: 40,
          color: const Color(0xFFF0AB20),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        _buildCompetitor(
          context,
          name: 'Competitor B',
          description: 'New entrant with innovative technology.',
          percentage: 15,
          color: const Color(0xFFF0AB20),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        _buildCompetitor(
          context,
          name: 'Competitor C',
          description: 'Focuses on a niche segment of the market.',
          percentage: 10,
          color: const Color(0xFFF0AB20),
        ),
      ],
    );
  }

  Widget _buildIndustryTag(BuildContext context, String label) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.height * 0.008,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: MediaQuery.of(context).size.width * 0.032,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMarketMetric(
    BuildContext context, {
    required String label,
    required String value,
    required bool hasTooltip,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.032,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
            if (hasTooltip) ...[
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
                size: MediaQuery.of(context).size.width * 0.04,
              ),
            ],
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.055,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCompetitor(
    BuildContext context, {
    required String name,
    required String description,
    required int percentage,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Competitor Avatar
        Container(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              name.split(' ')[1], // Gets "A", "B", "C"
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.04),

        // Competitor Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.width * 0.037,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                description,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // Progress bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percentage / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModelContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Business Model Title
        Text(
          'Business Model',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // Revenue Streams
        Text(
          'Revenue Streams',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        Row(
          children: [
            Expanded(
              child: _buildRevenueStream(
                context,
                icon: Icons.monetization_on_outlined,
                label: 'Subscription',
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.06),
            Expanded(
              child: _buildRevenueStream(
                context,
                icon: Icons.campaign_outlined,
                label: 'Ad Revenue',
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        Row(
          children: [
            Expanded(
              child: _buildRevenueStream(
                context,
                icon: Icons.business_outlined,
                label: 'B2B SaaS',
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.06),
            Expanded(
              child: _buildRevenueStream(
                context,
                icon: Icons.store_outlined,
                label: 'Marketplace Commission',
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Current Pricing Example
        Text(
          'Current Pricing Example',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Text(
          '\$29/month for Basic Tier, 5% transaction fee on marketplace sales.',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Distribution Channels
        Text(
          'Distribution Channels',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Text(
          'Direct Sales, Online Ads, Partnerships, App Stores',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Go-To-Market Strategy
        Text(
          'Go-To-Market Strategy (GTM)',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Text(
          'Key Channels:',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),

        Text(
          'Digital Marketing, Content Marketing, Community Building',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Row(
          children: [
            Text(
              'Expected CAC:',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.035,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Text(
              '\$50 per customer',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.035,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Scalability Potential
        Text(
          'Scalability Potential',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        Text(
          'The model is highly scalable with potential for network effects as more users join the platform. Future expansion into adjacent markets and international regions is planned. The technology infrastructure is built on a serverless architecture, allowing for seamless scaling to meet growing demand.',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildRevenueStream(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.grey[600],
            size: MediaQuery.of(context).size.width * 0.06,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.032,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTractionContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Traction & KPIs Title
        Text(
          'Traction & KPIs',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // Key Metrics Row
        Row(
          children: [
            Expanded(
              child: _buildKeyMetric(
                context,
                label: 'Current Customers/Users',
                value: '10,000',
                subtitle: 'active users',
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.06),
            Expanded(
              child: _buildKeyMetric(
                context,
                label: 'Revenue (MRR)',
                value: '\$20k',
                subtitle: 'monthly recurring',
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // Growth Rate
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // 🔑 aligns everything left
          children: [
            Text(
              'Growth Rate',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.032,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.trending_up,
                  color: const Color.fromARGB(255, 8, 6, 1),
                  size: MediaQuery.of(context).size.width * 0.05,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  '15% MoM',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 9, 6, 1),
                  ),
                ),
              ],
            ),
            Text(
              'month-over-month',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.028,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Detailed KPI Breakdown
        Text(
          'Detailed KPI Breakdown',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        _buildDetailedKPI(
          context,
          label: 'DAU',
          value: '3.2k',
          subtitle: 'Daily Active Users',
          hasChart: true,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        _buildDetailedKPI(
          context,
          label: 'LTV',
          value: '\$150',
          subtitle: 'Customer Lifetime Value',
          hasChart: true,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        _buildDetailedKPI(
          context,
          label: 'CAC',
          value: '\$25',
          subtitle: 'Customer Acquisition Cost',
          hasChart: true,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        _buildDetailedKPI(
          context,
          label: 'Retention',
          value: '85%',
          subtitle: 'Month 1 Retention Rate',
          hasChart: false,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Milestones Achieved
        Text(
          'Milestones Achieved',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),

        _buildMilestone(context, 'Launched Android App', 'Jan 2024'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _buildMilestone(context, 'Closed Seed Round', 'Dec 2023'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _buildMilestone(context, 'Reached 1,000 Beta Users', 'Oct 2023'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // View Proof of Traction Button
        Center(
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Opening traction proof...',
                    style: TextStyle(fontFamily: "Poppins"),
                  ),
                  backgroundColor: Colors.grey[600],
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
                vertical: MediaQuery.of(context).size.height * 0.015,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    color: Colors.grey[600],
                    size: MediaQuery.of(context).size.width * 0.045,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Text(
                    'View Proof of Traction',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // NEW FUNDING SECTION
  Widget _buildFundingContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Funding Request Title
        Text(
          'Funding Request',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // Funding Details Row
        Row(
          children: [
            Expanded(
              child: _buildFundingDetail(
                context,
                label: 'FUNDING REQUIRED',
                value: '\$500,000',
                subtitle: 'USD',
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.06),
            Expanded(
              child: _buildFundingDetail(
                context,
                label: 'TYPE OF FUNDING',
                value: 'Equity',
                subtitle: '',
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),

        // Equity Offered
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EQUITY OFFERED',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.032,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.008),
            Text(
              '15%',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Use of Funds
        Text(
          'Use of Funds',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        _buildUseOfFunds(
          context,
          'Product Development: 40%',
          0.4,
          const Color(0xFFF0AB20),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _buildUseOfFunds(
          context,
          'Marketing: 30%',
          0.3,
          const Color(0xFFF0AB20),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _buildUseOfFunds(context, 'Hiring: 20%', 0.2, const Color(0xFFF0AB20)),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _buildUseOfFunds(
          context,
          'Operations: 10%',
          0.1,
          const Color(0xFFF0AB20),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Expected Milestones
        Text(
          'Expected Milestones',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.045,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        _buildExpectedMilestone(context, 'Launch V2.0', 'Q3 2024'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _buildExpectedMilestone(context, 'Reach 50k MAU', 'Q4 2024'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        _buildExpectedMilestone(context, 'Achieve Break-Even', 'Q2 2025'),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }

  // HELPER METHODS
  Widget _buildContentItem(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        Text(
          content,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildKeyMetric(
    BuildContext context, {
    required String label,
    required String value,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.032,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.055,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.028,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedKPI(
    BuildContext context, {
    required String label,
    required String value,
    required String subtitle,
    required bool hasChart,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                value,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.028,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        if (hasChart)
          Expanded(
            flex: 2,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(8, (index) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.015,
                    height: (index + 1) * 4.0,
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown[200],
                      borderRadius: BorderRadius.circular(1),
                    ),
                  );
                }),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMilestone(BuildContext context, String title, String date) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.035,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: MediaQuery.of(context).size.width * 0.032,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundingDetail(
    BuildContext context, {
    required String label,
    required String value,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.032,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.008),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.055,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: MediaQuery.of(context).size.width * 0.028,
              color: Colors.grey[500],
            ),
          ),
      ],
    );
  }

  Widget _buildUseOfFunds(
    BuildContext context,
    String text,
    double percentage,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.03,
          height: MediaQuery.of(context).size.width * 0.03,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpectedMilestone(
    BuildContext context,
    String title,
    String timeline,
  ) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.025,
            height: MediaQuery.of(context).size.width * 0.025,
            decoration: const BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: MediaQuery.of(context).size.width * 0.037,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.003),
                Text(
                  timeline,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: MediaQuery.of(context).size.width * 0.032,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
