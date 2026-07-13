import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final activeIndex = 0.obs;
  bool _isScrollingToTab = false;
  late final List<GlobalKey> keys;

  void initKeys(int count) {
    keys = List.generate(count, (index) => GlobalKey());
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void scrollToIndex(int index, {GlobalKey<ScaffoldState>? scaffoldKey}) {
    _isScrollingToTab = true;
    activeIndex.value = index;

    // Close mobile drawer if it's open
    if (scaffoldKey?.currentState?.isDrawerOpen ?? false) {
      Get.back();
    }

    final context = keys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      ).then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _isScrollingToTab = false;
        });
      });
    } else {
      _isScrollingToTab = false;
    }
  }

  void _onScroll() {
    if (_isScrollingToTab) return;

    for (int i = 0; i < keys.length; i++) {
      final keyContext = keys[i].currentContext;
      if (keyContext != null) {
        final renderBox = keyContext.findRenderObject() as RenderBox?;
        if (renderBox != null && renderBox.hasSize) {
          final position = renderBox.localToGlobal(Offset.zero);
          final offsetInViewport = position.dy;
          
          if (offsetInViewport <= 150 && offsetInViewport > -renderBox.size.height + 150) {
            if (activeIndex.value != i) {
              activeIndex.value = i;
            }
            break;
          }
        }
      }
    }
  }
}
