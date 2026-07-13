import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/social_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewProjectsTap;

  const HeroSection({super.key, required this.onViewProjectsTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isDesktop = width > 900;

    return Container(
      constraints: BoxConstraints(minHeight: size.height - 70.h),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60.0.w : 24.0.w,
        vertical: 40.0.h,
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (isDesktop) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: _buildHeroText(context, true)),
                      SizedBox(width: 40.w),
                      Expanded(
                        flex: 4,
                        child: Center(child: _buildHeroImage(280.r)),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
                  _buildScrollDownIndicator(),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  _buildHeroImage(200.r),
                  SizedBox(height: 40.h),
                  _buildHeroText(context, false),
                  SizedBox(height: 60.h),
                  _buildScrollDownIndicator(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeroText(BuildContext context, bool isDesktop) {
    final alignment = isDesktop
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;
    final textAlignment = isDesktop ? TextAlign.left : TextAlign.center;

    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.textPrimary, AppColors.textSecondary],
          ).createShader(bounds),
          child: Text(
            "Hi, I'm",
            style: TextStyle(
              fontSize: isDesktop ? 36.sp : 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
              AppColors.accentGlow,
            ],
          ).createShader(bounds),
          child: Text(
            "Riya\nBiswas",
            textAlign: textAlignment,
            style: TextStyle(
              fontSize: isDesktop ? 68.sp : 44.sp,
              fontWeight: FontWeight.w900,
              height: 1.1,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        const TypewriterSubtitle(),
        SizedBox(height: 24.h),
        SizedBox(
          width: 500.w,
          child: Text(
            "Building impactful products that solve meaningful problems and create lasting value for users. 🚀",
            textAlign: textAlignment,
            style: TextStyle(
              fontSize: isDesktop ? 18.sp : 15.sp,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 32.h),
        // Action Buttons
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _HeroActionButton(
              text: "Download Resume",
              icon: Icons.download,
              isPrimary: true,
              onTap: () {},
            ),
            _HeroActionButton(
              text: "View Projects",
              icon: Icons.arrow_forward,
              isPrimary: false,
              onTap: onViewProjectsTap,
            ),
          ],
        ),
        SizedBox(height: 32.h),
        // Social icons
        Row(
          mainAxisAlignment: isDesktop
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            SocialButton(icon: FontAwesomeIcons.github, url: "", onTap: () {}),
            SizedBox(width: 12.w),
            SocialButton(
              icon: FontAwesomeIcons.linkedin,
              url: "",
              onTap: () {},
            ),
            SizedBox(width: 12.w),
            SocialButton(
              icon: FontAwesomeIcons.bookOpen,
              url: "",
              onTap: () {},
            ),
            SizedBox(width: 12.w),
            SocialButton(icon: FontAwesomeIcons.code, url: "", onTap: () {}),
            SizedBox(width: 12.w),
            SocialButton(
              icon: FontAwesomeIcons.envelope,
              url: "",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size * 0.8,
          height: size * 0.8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.15),
                blurRadius: 45.r,
                spreadRadius: 20.r,
              ),
            ],
          ),
        ),
        Lottie.asset(
          'assets/lottie/Coding Genius.json',
          width: size * 2,
          height: size * 2,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget _buildScrollDownIndicator() {
    return const _ScrollDownIndicator();
  }
}

class TypewriterSubtitle extends StatefulWidget {
  const TypewriterSubtitle({super.key});

  @override
  State<TypewriterSubtitle> createState() => _TypewriterSubtitleState();
}

class _TypewriterSubtitleState extends State<TypewriterSubtitle> {
  final List<String> _roles = [
    "Frontend Developer",
    "Flutter Developer",
    "Mobile Engineer",
  ];
  int _roleIndex = 0;
  int _charIndex = 0;
  String _currentText = "";
  bool _isDeleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTyping();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTyping() {
    if (!mounted) return;
    const typingSpeed = Duration(milliseconds: 100);
    const deletingSpeed = Duration(milliseconds: 50);
    const holdDuration = Duration(seconds: 2);

    final fullWord = _roles[_roleIndex];

    if (!_isDeleting) {
      if (_charIndex < fullWord.length) {
        setState(() {
          _currentText = fullWord.substring(0, _charIndex + 1);
          _charIndex++;
        });
        _timer = Timer(typingSpeed, _startTyping);
      } else {
        _timer = Timer(holdDuration, () {
          if (mounted) {
            setState(() {
              _isDeleting = true;
            });
            _startTyping();
          }
        });
      }
    } else {
      if (_charIndex > 0) {
        setState(() {
          _currentText = fullWord.substring(0, _charIndex - 1);
          _charIndex--;
        });
        _timer = Timer(deletingSpeed, _startTyping);
      } else {
        setState(() {
          _isDeleting = false;
          _roleIndex = (_roleIndex + 1) % _roles.length;
        });
        _timer = Timer(typingSpeed, _startTyping);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _currentText,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
            letterSpacing: 0.5,
          ),
        ),
        const _BlinkingCursor(),
      ],
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  const _BlinkingCursor();

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 500),
        )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Text(
        "|",
        style: TextStyle(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}

class _HeroActionButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HeroActionButton({
    required this.text,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_HeroActionButton> createState() => _HeroActionButtonState();
}

class _HeroActionButtonState extends State<_HeroActionButton> {
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
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_isHovered
                      ? AppColors.primary.withOpacity(0.85)
                      : AppColors.primary)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: widget.isPrimary
                  ? Colors.transparent
                  : AppColors.glassBorder,
              width: 1.5,
            ),
            boxShadow: (widget.isPrimary && _isHovered)
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 15.r,
                      spreadRadius: 2.r,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, color: AppColors.textPrimary, size: 18.r),
              SizedBox(width: 8.w),
              Text(
                widget.text,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedProfileContainer extends StatefulWidget {
  final double size;

  const _AnimatedProfileContainer({required this.size});

  @override
  State<_AnimatedProfileContainer> createState() =>
      _AnimatedProfileContainerState();
}

class _AnimatedProfileContainerState extends State<_AnimatedProfileContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer rotating ring (Dashed/Dotted)
        RotationTransition(
          turns: _rotationController,
          child: CustomPaint(
            size: Size(widget.size + 40.w, widget.size + 40.h),
            painter: _DottedCirclePainter(
              color: AppColors.primary.withOpacity(0.5),
              dashCount: 40,
              dashWidth: 4.w,
            ),
          ),
        ),
        // Middle rotating ring (Solid with dots)
        RotationTransition(
          turns: ReverseAnimation(_rotationController),
          child: CustomPaint(
            size: Size(widget.size + 20.w, widget.size + 20.h),
            painter: _DottedCirclePainter(
              color: AppColors.secondary.withOpacity(0.3),
              dashCount: 20,
              dashWidth: 6.w,
            ),
          ),
        ),
        // Main Image Container
        Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.3),
                blurRadius: 30.r,
                spreadRadius: 5.r,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.surfaceColor,
                  child: Icon(
                    Icons.person,
                    size: 80.r,
                    color: AppColors.textSecondary,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DottedCirclePainter extends CustomPainter {
  final Color color;
  final int dashCount;
  final double dashWidth;

  _DottedCirclePainter({
    required this.color,
    required this.dashCount,
    required this.dashWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);
    final double dashAngle = (2 * math.pi) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final double angle = i * dashAngle;
      if (i % 2 == 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          angle,
          dashAngle * 0.5,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ScrollDownIndicator extends StatefulWidget {
  const _ScrollDownIndicator();

  @override
  State<_ScrollDownIndicator> createState() => _ScrollDownIndicatorState();
}

class _ScrollDownIndicatorState extends State<_ScrollDownIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _scrollController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _scrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(begin: 4.0.h, end: 14.0.h).animate(
      CurvedAnimation(parent: _scrollController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Scroll down",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 20.w,
          height: 32.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColors.textSecondary.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    top: _animation.value,
                    child: Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
