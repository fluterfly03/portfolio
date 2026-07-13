import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  ScrollController scrollController = ScrollController();
  final activeIndex = 0.obs;
  bool _isScrollingToTab = false;
  final List<GlobalKey> keys = List.generate(7, (index) => GlobalKey());

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
  }

  void setScrollController(ScrollController controller) {
    try {
      scrollController.removeListener(_onScroll);
    } catch (_) {}
    scrollController = controller;
    scrollController.addListener(_onScroll);
  }

  void initKeys(int count) {
    // Deprecated: Keys are now initialized inline.
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
      scaffoldKey?.currentState?.closeDrawer();
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isScrollingToTab) return;
      if (scrollController.hasClients == false) return;

      for (int i = 0; i < keys.length; i++) {
        final keyContext = keys[i].currentContext;
        if (keyContext != null) {
          final renderBox = keyContext.findRenderObject() as RenderBox?;
          if (renderBox != null && renderBox.hasSize && renderBox.attached) {
            final position = renderBox.localToGlobal(Offset.zero);
            final offsetInViewport = position.dy;

            if (offsetInViewport <= 150 &&
                offsetInViewport > -renderBox.size.height + 150) {
              if (activeIndex.value != i) {
                activeIndex.value = i;
              }
              break;
            }
          }
        }
      }
    });
  }
}
