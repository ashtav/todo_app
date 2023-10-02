// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/app/providers/todo/todo_provider.dart';

class FormTodoView extends ConsumerWidget {
  const FormTodoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todoProvider.notifier);

    // reset form
    notifier.title.clear();
    notifier.description.clear();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(
            controller: notifier.title,
            hint: 'Type title',
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextField(
            controller: notifier.description,
            hint: 'Type description',
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () async {
            await notifier.create();
            context.pop();
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  const CustomTextField({super.key, this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
