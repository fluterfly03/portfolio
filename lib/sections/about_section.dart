import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
          _buildSectionHeader("About Me"),
          SizedBox(height: 40.h),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildStatsGrid(),
                    ),
                    SizedBox(width: 60.w),
                    Expanded(
                      flex: 6,
                      child: _buildAboutDescription(),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildAboutDescription(),
                    SizedBox(height: 40.h),
                    _buildStatsGrid(),
                  ],
                );
              }
            },
          ),
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

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      childAspectRatio: 1.3,
      children: const [
        _StatCard(number: "2+", label: "Years Experience"),
        _StatCard(number: "15+", label: "Projects Completed"),
        _StatCard(number: "5+", label: "Open Source Apps"),
        _StatCard(number: "100%", label: "Client Satisfaction"),
      ],
    );
  }

  Widget _buildAboutDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Designing and coding beautiful, responsive digital experiences",
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "I am a passionate Frontend and Flutter developer dedicated to building impactful products that solve user problems. With experience in creating sleek user interfaces and efficient state management, I focus on delivering seamless applications across Android, iOS, and Web platforms.",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16.sp,
            height: 1.6,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          "My design philosophy revolves around simplicity, accessibility, and high performance. I love translating complex designs into clean, maintainable code using Dart, Flutter, and modern web frameworks.",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16.sp,
            height: 1.6,
          ),
        ),
        SizedBox(height: 24.h),
        // Personal info table
        Wrap(
          spacing: 24.w,
          runSpacing: 12.h,
          children: const [
            _InfoRow(label: "Location", value: "Mumbai, India"),
            _InfoRow(label: "Email", value: "riya@example.com"),
            _InfoRow(label: "Availability", value: "Freelance & Full-time"),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatefulWidget {
  final String number;
  final String label;

  const _StatCard({required this.number, required this.label});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _isHovered 
              ? AppColors.primary.withOpacity(0.08) 
              : AppColors.surfaceColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.glassBorder,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 12.r,
                    spreadRadius: 1.r,
                  )
                ]
              : [],
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.number,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              widget.label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
