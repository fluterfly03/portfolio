import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

class ExperienceItem {
  final String role;
  final String company;
  final String period;
  final String description;

  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
  });
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  final List<ExperienceItem> experiences = const [
    ExperienceItem(
      role: "Frontend Developer Intern",
      company: "Innovate Tech Labs",
      period: "Jul 2025 - Present",
      description: "Developed and optimized key features for user-facing web applications. Implemented pixel-perfect responsive layouts using HTML, CSS, and modern framework systems. Worked closely with design teams to refine UI/UX assets.",
    ),
    ExperienceItem(
      role: "Mobile App Developer",
      company: "Freelance",
      period: "Jan 2024 - Jun 2025",
      description: "Designed, built, and launched multiple cross-platform Flutter applications on Play Store & App Store. Integrated Firebase services for real-time databases, authentication, and push notifications.",
    ),
    ExperienceItem(
      role: "Open Source Contributor",
      company: "Flutter Community",
      period: "Sep 2023 - Dec 2023",
      description: "Contributed bug fixes, performance improvements, and documentation edits to popular Flutter packages. Collaborated with global maintainers on GitHub.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60.0.w : 24.0.w,
        vertical: 80.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Work Experience"),
          SizedBox(height: 50.h),
          _buildTimeline(isDesktop),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 60.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(bool isDesktop) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        return _TimelineTile(
          item: experiences[index],
          isLast: index == experiences.length - 1,
          isDesktop: isDesktop,
        );
      },
    );
  }
}

class _TimelineTile extends StatefulWidget {
  final ExperienceItem item;
  final bool isLast;
  final bool isDesktop;

  const _TimelineTile({
    required this.item,
    required this.isLast,
    required this.isDesktop,
  });

  @override
  State<_TimelineTile> createState() => _TimelineTileState();
}

class _TimelineTileState extends State<_TimelineTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator line
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 16.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: _isHovered ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3.r,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.6),
                            blurRadius: 10.r,
                            spreadRadius: 2.r,
                          )
                        ]
                      : [],
                ),
              ),
              if (!widget.isLast)
                Expanded(
                  child: Container(
                    width: 2.w,
                    color: AppColors.glassBorder,
                  ),
                ),
            ],
          ),
          SizedBox(width: 24.w),
          // Content block
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(bottom: 30.h),
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: _isHovered 
                      ? AppColors.primary.withOpacity(0.05) 
                      : AppColors.surfaceColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: _isHovered ? AppColors.primary : AppColors.glassBorder,
                    width: 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.1),
                            blurRadius: 12.r,
                            spreadRadius: 1.r,
                          )
                        ]
                      : [],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final showSideBySide = widget.isDesktop && constraints.maxWidth > 500.w;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showSideBySide)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  widget.item.role,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                widget.item.period,
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        else ...[
                          Text(
                            widget.item.role,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            widget.item.period,
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                        SizedBox(height: 6.h),
                        Text(
                          widget.item.company,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          widget.item.description,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14.sp,
                            height: 1.5,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
