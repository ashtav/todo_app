import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/core/extensions/riverpod_extension.dart';
import 'package:todo_app/app/data/models/todo1.dart';
import 'package:todo_app/app/providers/todo/todo_detail_provider.dart';

class TodoDetailView extends ConsumerWidget {
  final Todo1 todo;
  const TodoDetailView({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          'Todo Detail',
        )),
        body: Consumer(
          builder: (context, ref, _) {
            final asyncData = ref.watch(todoDetailProvider(todo.id!));
            return asyncData.when(
                data: (data) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ID'),
                        Text('${data.id}'),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Title'),
                        Text('${data.title}'),
                      ],
                    ),
                  );
                },
                error: (e, s) => Center(
                      child: Text(e.toString()),
                    ),
                loading: () => const Center(
                      child: Text('Loading...'),
                    ));
          },
        ));
  }
}
