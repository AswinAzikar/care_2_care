import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

import '../../exporter.dart';
import '../../main.dart';
import '../../mixins/force_update.dart';
import '../../widgets/common_sheet.dart';
import '../../widgets/loading_button.dart';
import 'models/screens.dart';

class NavigationController extends ValueNotifier<Screens> {
  static const String path = "/navigation";
  NavigationController(super._value);
}

final navigationController = NavigationController(Screens.home);

class NavigationScreen extends StatefulWidget {
  static const String path = "/navigation";

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with ForceUpdateMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    checkVersion();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.resumed:
        checkVersion();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: navigationController,
      builder: (context, child) {
        return PopScope(
          onPopInvoked: onPopInvoked,
          canPop: false,
          child: Scaffold(
            drawerEnableOpenDragGesture: false,
            body: IndexedStack(
              index: navigationController.value.index,
              children: Screens.values.map((e) => e.body).toList(),
            ),
            bottomNavigationBar: BottomBarFloating(
              items: Screens.values.map((screen) {
                return TabItem(
                  icon: (screen.bottomIcon as Icon).icon, // Extract IconData
                  title: screen.label,
                );
              }).toList(),
              onTap: (index) {
                if (navigationController.value.index == index) {
                  Screens.values[index].popAll();
                }
                navigationController.value = Screens.values[index];
              },
              indexSelected: navigationController.value.index,
              backgroundColor: Colors.white,
              color: Colors.grey,
              colorSelected: lightGreen,
              animated: true,
            ),
          ),
        );
      },
    );
  }

  void onPopInvoked(bool didPop) async {
    if (Navigator.canPop(navigationController.value.context)) {
      Navigator.maybePop(navigationController.value.context);
    } else {
      final result = await showModalBottomSheet(
        context: navigatorKey.currentContext!,
        builder: (context) => CommonBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gapXL,
              const Text("You are about to exit from the app"),
              gapXL,
              LoadingButton(
                buttonLoading: false,
                text: "Exit",
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ),
      );
      if (result == null) return;
      SystemNavigator.pop(
        animated: true,
      );
    }
  }
}
