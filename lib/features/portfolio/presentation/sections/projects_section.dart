import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String githubUrl;
  final String liveUrl;

  const Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
    required this.liveUrl,
  });
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  final List<Project> projects = const [
    Project(
      title: "Task Management App",
      description:
          "A cross-platform Flutter application for personal and team task management, featuring real-time syncing, offline mode, and push notifications.",
      tags: ["Flutter", "Dart", "Firebase", "BLoC"],
      githubUrl: "",
      liveUrl: "",
    ),
    Project(
      title: "Glassmorphism Portfolio",
      description:
          "A fully responsive personal portfolio built entirely with Flutter Web, implementing custom animations, rich color palettes, and glassmorphic designs.",
      tags: ["Flutter Web", "Responsive", "Glassmorphism"],
      githubUrl: "",
      liveUrl: "",
    ),
    Project(
      title: "E-Commerce System",
      description:
          "An online marketplace featuring product catalogs, cart management, and integrated secure payment gateways, built for mobile and web platforms.",
      tags: ["Flutter", "Hive DB", "Stripe API", "Provider"],
      githubUrl: "",
      liveUrl: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    final crossAxisCount = width > 1100 ? 3 : (width > 700 ? 2 : 1);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60.0.w : 24.0.w,
        vertical: 80.0.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Projects"),
          SizedBox(height: 50.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24.w,
              mainAxisSpacing: 24.h,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              return _ProjectCard(project: projects[index]);
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

class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
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
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 20.r,
                    spreadRadius: 1.r,
                  ),
                ]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Header Image Placeholder
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    AppColors.secondary.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: const Border(
                  bottom: BorderSide(color: AppColors.glassBorder, width: 1),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.code,
                  size: 44.r,
                  color: _isHovered ? AppColors.primary : AppColors.secondary,
                ),
              ),
            ),
            // Project Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13.sp,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Tags
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: widget.project.tags.map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.h),
                    // Action links
                    Row(
                      children: [
                        _ProjectLink(
                          icon: FontAwesomeIcons.github,
                          label: "Code",
                          onTap: () {},
                        ),
                        SizedBox(width: 16.w),
                        _ProjectLink(
                          icon: FontAwesomeIcons.arrowUpRightFromSquare,
                          label: "Live Demo",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectLink extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProjectLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ProjectLink> createState() => _ProjectLinkState();
}

class _ProjectLinkState extends State<_ProjectLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            FaIcon(
              widget.icon,
              size: 14.r,
              color: _isHovered ? AppColors.primary : AppColors.textSecondary,
            ),
            SizedBox(width: 6.w),
            Text(
              widget.label,
              style: TextStyle(
                color: _isHovered ? AppColors.primary : AppColors.textSecondary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                decoration: _isHovered
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
