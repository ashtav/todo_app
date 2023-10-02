import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/core/constants/value.dart';
import 'package:todo_app/app/core/extensions/riverpod_extension.dart';
import 'package:todo_app/app/screens/support/views/support_view.dart';
import 'package:todo_app/app/screens/todo/views/todo_view.dart';

import '../../../providers/app_provider.dart';
import '../../account/views/account_view.dart';
import 'home_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    globalContext = context;

    List<IconData> icons = [TablerIcons.home, TablerIcons.note, TablerIcons.message_2, TablerIcons.user];
    List<Widget> pages = const [HomeView(), TodoView(), SupportView(), AccountView()];
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: appStateProvider.watch((state) => Stack(
                children: List<Widget>.generate(4, (int index) {
              bool isActive = state.page == index;

              return IgnorePointer(
                ignoring: !isActive,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 250),
                  opacity: isActive ? 1 : 0,
                  child: Navigator(
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute(
                        builder: (_) => pages[index],
                        settings: settings,
                      );
                    },
                  ),
                ),
              );
            }))),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
          child: appStateProvider.watch(
            (state) => Stack(
              children: [
                IntrinsicHeight(
                    child: Row(
                  children: List.generate(icons.length, (i) {
                    bool isActive = state.page == i;
                    Color colorActive = isActive ? Colors.black87 : Colors.black45;
                    IconData icon = icons[i];

                    return Expanded(
                        child: InkWell(
                      onTap: () {
                        final notifier = ref.read(appStateProvider.notifier);
                        notifier.navigateTo(i);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icon,
                              color: colorActive,
                            )
                          ],
                        ),
                      ),
                    ));
                  }),
                )),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  top: 0,
                  left: (width / 4) * state.page,
                  curve: Curves.elasticInOut,
                  child: Container(
                    height: 2,
                    width: width / 4,
                    decoration: const BoxDecoration(color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
