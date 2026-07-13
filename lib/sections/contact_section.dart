import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/colors.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
          _buildSectionHeader("Contact Me"),
          SizedBox(height: 50.h),
          LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildContactInfoCard(),
                    ),
                    SizedBox(width: 48.w),
                    Expanded(
                      flex: 6,
                      child: _buildContactFormCard(),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildContactInfoCard(),
                    SizedBox(height: 32.h),
                    _buildContactFormCard(),
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

  Widget _buildContactInfoCard() {
    return Container(
      padding: EdgeInsets.all(32.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.glassBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let's Connect",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Have an exciting project idea or want to collaborate? Feel free to drop a message, and I'll get back to you as soon as possible!",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 32.h),
          _buildInfoItem(Icons.email_outlined, "Email", "riya@example.com"),
          SizedBox(height: 24.h),
          _buildInfoItem(Icons.map_outlined, "Location", "Mumbai, India"),
          SizedBox(height: 24.h),
          _buildInfoItem(Icons.work_outline, "Status", "Open for Work"),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.primary.withOpacity(0.2), width: 1),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20.r),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactFormCard() {
    return const _ContactForm();
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isHoveredButton = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.glassBorder, width: 1.5),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Send Message",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.h),
            _buildTextField(
              controller: _nameController,
              label: "Your Name",
              icon: Icons.person_outline,
            ),
            SizedBox(height: 20.h),
            _buildTextField(
              controller: _emailController,
              label: "Your Email",
              icon: Icons.alternate_email,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.h),
            _buildTextField(
              controller: _messageController,
              label: "Message",
              icon: Icons.chat_bubble_outline,
              maxLines: 5,
            ),
            SizedBox(height: 24.h),
            MouseRegion(
              onEnter: (_) => setState(() => _isHoveredButton = true),
              onExit: (_) => setState(() => _isHoveredButton = false),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Thank you! Your message has been sent.",
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                    _nameController.clear();
                    _emailController.clear();
                    _messageController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                  elevation: _isHoveredButton ? 8 : 2,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.send, color: AppColors.textPrimary, size: 16.r),
                    SizedBox(width: 8.w),
                    Text(
                      "Send Message",
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 18.r),
        filled: true,
        fillColor: AppColors.backgroundStart.withOpacity(0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label is required";
        }
        return null;
      },
    );
  }
}
