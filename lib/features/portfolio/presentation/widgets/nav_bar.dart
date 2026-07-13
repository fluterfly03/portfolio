import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class HexagonPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  HexagonPainter({required this.color, this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.75);
    path.lineTo(0, h * 0.25);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final int activeIndex;
  final List<String> sections;
  final Function(int) onTabSelected;
  final VoidCallback onMenuPressed;

  const NavBar({
    super.key,
    required this.activeIndex,
    required this.sections,
    required this.onTabSelected,
    required this.onMenuPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          height: 70.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: const Border(
              bottom: BorderSide(color: AppColors.glassBorder, width: 1),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Row(
            children: [
              // Logo
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => onTabSelected(0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: Size(40.w, 44.h),
                        painter: HexagonPainter(
                          color: AppColors.primary,
                          strokeWidth: 1.5,
                        ),
                      ),
                      Text(
                        'P',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // Floating dot
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
              const Spacer(),
              if (isDesktop) ...[
                // Tabs
                Row(
                  children: List.generate(sections.length, (index) {
                    final isSelected = index == activeIndex;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: _NavTab(
                        title: sections[index],
                        isSelected: isSelected,
                        onTap: () => onTabSelected(index),
                      ),
                    );
                  }),
                ),
                SizedBox(width: 16.w),
                // Icons (Theme, Palette, Resume)
                IconButton(
                  icon: Icon(
                    Icons.dark_mode_outlined,
                    color: AppColors.textSecondary,
                    size: 20.r,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.palette_outlined,
                    color: AppColors.textSecondary,
                    size: 20.r,
                  ),
                  onPressed: () {},
                ),
                SizedBox(width: 16.w),
                _ResumeButton(onPressed: () {}),
              ] else ...[
                // Mobile Menu
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.textPrimary),
                  onPressed: onMenuPressed,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavTab({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavTab> createState() => _NavTabState();
}

class _NavTabState extends State<_NavTab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColors.primary.withOpacity(0.2)
                : (_isHovered
                      ? AppColors.primary.withOpacity(0.08)
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: widget.isSelected ? AppColors.primary : Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: (widget.isSelected || _isHovered)
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: 14.sp,
              fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _ResumeButton({required this.onPressed});

  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shadowColor: AppColors.primary.withOpacity(0.5),
          elevation: _isHovered ? 8 : 2,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        icon: Icon(Icons.download, size: 18.r, color: AppColors.textPrimary),
        label: Text(
          'Resume',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
