import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/core/constants/font.dart';
import 'package:todo_app/app/core/extensions/riverpod_extension.dart';
import 'package:todo_app/app/providers/todo/todo_provider.dart';
import 'package:todo_app/app/routes/paths.dart';

class TodoView extends ConsumerWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo',
          style: Gfont.color(Colors.black).fsize(20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(todoProvider.notifier).getTodos();
              },
              icon: const Icon(TablerIcons.refresh)),
          IconButton(
              onPressed: () {
                context.push(Paths.formTodo);
              },
              icon: const Icon(TablerIcons.plus))
        ],
      ),
      body: todoProvider.watch((value) {
        return value.when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(child: Text('No data found, please add new.'));
              }

              return ListView(
                padding: const EdgeInsets.all(20),
                children: List.generate(data.length, (i) {
                  final key = GlobalKey();
                  final item = data[i];

                  return InkWell(
                    onTap: () {
                      context.push(Paths.todoDetail, extra: item);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              item.title ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(TablerIcons.dots_vertical, color: Colors.black45, key: key)
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
            error: (e, s) => Center(
                  child: Text(
                    'Error: $e',
                  ),
                ),
            loading: () => const Center(child: Text('Loading...')));
      }),
    );
  }
}
