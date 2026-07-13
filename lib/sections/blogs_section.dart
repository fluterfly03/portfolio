import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

class BlogItem {
  final String title;
  final String date;
  final String readTime;
  final String teaser;

  const BlogItem({
    required this.title,
    required this.date,
    required this.readTime,
    required this.teaser,
  });
}

class BlogsSection extends StatelessWidget {
  const BlogsSection({super.key});

  final List<BlogItem> blogs = const [
    BlogItem(
      title: "Flutter Web Performance Optimization",
      date: "May 12, 2026",
      readTime: "5 min read",
      teaser: "Learn how to optimize your Flutter Web builds for faster loads, smooth animations, and better SEO discoverability.",
    ),
    BlogItem(
      title: "State Management in 2026: Choosing the Right Package",
      date: "Mar 28, 2026",
      readTime: "8 min read",
      teaser: "A comprehensive breakdown comparing BLoC, Riverpod, and Signal solutions for modern, scalable Flutter applications.",
    ),
    BlogItem(
      title: "Creating High Fidelity Glassmorphic UI in Flutter",
      date: "Jan 15, 2026",
      readTime: "4 min read",
      teaser: "Deep dive into using BackdropFilter, custom gradients, and transparent borders to achieve beautiful frosted glass designs.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;
    
    final crossAxisCount = width > 1100 
        ? 3 
        : (width > 700 ? 2 : 1);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60.0.w : 24.0.w,
        vertical: 80.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Blogs & Articles"),
          SizedBox(height: 50.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: blogs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24.w,
              mainAxisSpacing: 24.h,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              return _BlogCard(item: blogs[index]);
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

class _BlogCard extends StatefulWidget {
  final BlogItem item;

  const _BlogCard({required this.item});

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: _isHovered ? AppColors.primary : AppColors.glassBorder,
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.12),
                    blurRadius: 15.r,
                    spreadRadius: 1.r,
                  )
                ]
              : [],
        ),
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.date,
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.item.readTime,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              widget.item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: Text(
                widget.item.teaser,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  "Read Article",
                  style: TextStyle(
                    color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.arrow_forward,
                  size: 14.r,
                  color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
