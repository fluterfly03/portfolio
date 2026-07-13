import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/colors.dart';

class SocialButton extends StatefulWidget {
  final FaIconData icon;
  final String url;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.icon,
    required this.url,
    required this.onTap,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _isHovered 
                ? AppColors.primary.withOpacity(0.15) 
                : AppColors.glassBackground,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered 
                  ? AppColors.primary 
                  : AppColors.glassBorder,
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: Center(
            child: FaIcon(
              widget.icon,
              color: _isHovered ? AppColors.primary : AppColors.textSecondary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
