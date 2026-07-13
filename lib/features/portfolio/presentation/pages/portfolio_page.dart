import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/navigation_controller.dart';
import '../widgets/nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/experience_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/blogs_section.dart';
import '../sections/contact_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final NavigationController navCtrl = Get.put(NavigationController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final ScrollController _scrollController;

  final List<String> _sections = [
    'Home',
    'About',
    'Experience',
    'Skills',
    'Projects',
    'Blogs',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    navCtrl.setScrollController(_scrollController);
    navCtrl.initKeys(_sections.length);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Obx(
          () => NavBar(
            activeIndex: navCtrl.activeIndex.value,
            sections: _sections,
            onTabSelected: (index) =>
                navCtrl.scrollToIndex(index, scaffoldKey: _scaffoldKey),
            onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
      ),
      drawer: !isDesktop
          ? Obx(
              () => Drawer(
                backgroundColor: AppColors.backgroundStart,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.backgroundStart,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Riya Biswas',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Frontend Developer',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(_sections.length, (index) {
                      final isSelected = index == navCtrl.activeIndex.value;
                      return ListTile(
                        title: Text(
                          _sections[index],
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                        selected: isSelected,
                        selectedTileColor: AppColors.primary.withOpacity(0.1),
                        onTap: () => navCtrl.scrollToIndex(
                          index,
                          scaffoldKey: _scaffoldKey,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            )
          : null,
      body: Stack(
        children: [
          // Background Gradient decoration
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Subtle Glowing Accents/Orbits in background (Vibrant purple blobs)
          Positioned(
            top: 200.h,
            left: -150.w,
            child: Container(
              width: 350.w,
              height: 350.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 300.h,
            right: -150.w,
            child: Container(
              width: 400.w,
              height: 400.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withOpacity(0.05),
              ),
            ),
          ),

          // Scrollable Sections Content
          SafeArea(
            top: false, // Let background extend behind status bar
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(height: 70.h), // Push below fixed Nav Bar
                  // Section 0: Home
                  Container(
                    key: navCtrl.keys[0],
                    child: HeroSection(
                      onViewProjectsTap: () => navCtrl.scrollToIndex(
                        4,
                      ), // Scroll to Projects (index 4)
                    ),
                  ),
                  // Section 1: About
                  Container(key: navCtrl.keys[1], child: const AboutSection()),
                  // Section 2: Experience
                  Container(
                    key: navCtrl.keys[2],
                    child: const ExperienceSection(),
                  ),
                  // Section 3: Skills
                  Container(key: navCtrl.keys[3], child: const SkillsSection()),
                  // Section 4: Projects
                  Container(
                    key: navCtrl.keys[4],
                    child: const ProjectsSection(),
                  ),
                  // Section 5: Blogs
                  Container(key: navCtrl.keys[5], child: const BlogsSection()),
                  // Section 6: Contact
                  Container(
                    key: navCtrl.keys[6],
                    child: const ContactSection(),
                  ),

                  // Footer
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.glassBorder, width: 1)),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              "Designed & Built by Riya Biswas ",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "© 2026 • All Rights Reserved",
              style: TextStyle(color: AppColors.textSecondary, fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}
