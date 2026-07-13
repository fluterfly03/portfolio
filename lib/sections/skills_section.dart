import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/colors.dart';

class SkillItem {
  final String name;
  final FaIconData icon;

  const SkillItem({required this.name, required this.icon});
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<SkillItem> skills = const [
    SkillItem(name: "Flutter", icon: FontAwesomeIcons.mobileScreenButton),
    SkillItem(name: "Dart", icon: FontAwesomeIcons.terminal),
    SkillItem(name: "Git / GitHub", icon: FontAwesomeIcons.github),
    SkillItem(name: "Firebase", icon: FontAwesomeIcons.fire),
    SkillItem(name: "HTML5", icon: FontAwesomeIcons.html5),
    SkillItem(name: "CSS3", icon: FontAwesomeIcons.css3Alt),
    SkillItem(name: "JavaScript", icon: FontAwesomeIcons.js),
    SkillItem(name: "UI / UX Design", icon: FontAwesomeIcons.palette),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;
    
    final crossAxisCount = width > 1000 
        ? 4 
        : (width > 600 ? 3 : 2);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60.0.w : 24.0.w,
        vertical: 80.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("My Skills"),
          SizedBox(height: 50.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skills.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              childAspectRatio: 1.4,
            ),
            itemBuilder: (context, index) {
              return _SkillCard(item: skills[index]);
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
}

class _SkillCard extends StatefulWidget {
  final SkillItem item;

  const _SkillCard({required this.item});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
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
              : AppColors.surfaceColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.glassBorder,
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 15.r,
                    spreadRadius: 1.r,
                  )
                ]
              : [],
        ),
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: _isHovered 
                  ? (Matrix4.identity()..translate(0, -4.h, 0)) 
                  : Matrix4.identity(),
              child: FaIcon(
                widget.item.icon,
                color: _isHovered ? AppColors.primary : AppColors.secondary,
                size: 36.r,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              widget.item.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _isHovered ? AppColors.textPrimary : AppColors.textSecondary,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
