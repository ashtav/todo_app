import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:todo_app/app/providers/todo/todo_provider.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo'),
          centerTitle: true,
          actions: [
            const Icon(Ti.plus).onPressed(() {})
          ],
        ),
        body: Consumer(builder: (context, ref, child) {
          final value = ref.watch(todoProvider);

          return value.when(
              data: (data) {
                if (data.isEmpty) {
                  return const LzNoData(message: 'No data found, please add new.');
                }

                return Refreshtor(
                  onRefresh: () => ref.read(todoProvider.notifier).getTodos(),
                  child: ListView(
                    physics: BounceScroll(),
                    padding: Ei.all(20),
                    children: data.generate((item, i) {
                      final key = GlobalKey();
                
                      return SlideUp(
                        delay: i * 150,
                        child: InkTouch(
                          onTap: () {
                            DropX.show(key,
                                options: ['Edit', 'Delete'].options(icons: [
                                  Ti.pencil,
                                  Ti.trash
                                ], dangers: [
                                  1
                                ], options: {
                                  1: ['Cancel', 'Confirm'].options(pops: [0], dangers: [1])
                                }), onSelect: (value) {
                              if (value.option == 'Edit') {}
                            });
                          },
                          padding: Ei.all(20),
                          border: Br.only(['t'], except: i == 0),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: Maa.spaceBetween,
                            children: [Text(item.title ?? ''), Icon(Ti.dotsVertical, color: Colors.black45, key: key)],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
              error: (e, s) => LzNoData(
                    message: 'Error: $e',
                  ),
              loading: () => LzLoader.bar(message: 'Loading...'));
        }));
  }
}
