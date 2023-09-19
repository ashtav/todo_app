import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
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

    List<Widget> pages = const [HomeView(), TodoView(), SupportView(), AccountView()];

    return Scaffold(
        body: appStateProvider.watch((state) => Stack(
                children: List<Widget>.generate(4, (int index) {
              bool isActive = state.page == index;

              return IgnorePointer(
                ignoring: !isActive,
                child: AnimatedOpacity(
                  duration: 250.ms,
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
          decoration: BoxDecoration(border: Br.only(['b'])),
          child: appStateProvider.watch(
            (state) => Stack(
              children: [
                Intrinsic(
                  children: [Ti.home, Ti.note, Ti.message2, Ti.user].generate((icon, i) {
                    bool isActive = state.page == i;
                    Color colorActive = isActive ? Colors.black87 : Colors.black45;

                    return Expanded(
                        child: InkTouch(
                      onTap: () {
                        final notifier = ref.read(appStateProvider.notifier);
                        notifier.navigateTo(i);
                      },
                      padding: Ei.sym(v: 20, h: 5),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: Maa.center,
                        children: [
                          Icon(
                            icon,
                            color: colorActive,
                          )
                        ],
                      ),
                    ));
                  }),
                ),
                AnimatedPositioned(
                  duration: 250.ms,
                  top: 0,
                  left: (context.width / 4) * state.page,
                  curve: Curves.elasticInOut,
                  child: Container(
                    height: 2,
                    width: context.width / 4,
                    decoration: const BoxDecoration(color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
