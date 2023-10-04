import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/todo.dart';
import '../../../providers/todo/todo_provider.dart';

class FormTodoView extends ConsumerWidget {
  final Todo? data;
  const FormTodoView({super.key, this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todoProvider.notifier);
    final forms = notifier.forms;

    String title = data.hasNull ? 'Add Todo' : 'Edit Todo';

    if(!data.hasNull){
      forms.fill(data!.toJson());
    }

    return Wrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: LzFormList(
          style: const LzFormStyle(
            type: FormType.topAligned,
            inputBorderColor: Colors.black45
          ),
          children: [
            LzForm.input(label: 'Todo Name *', hint: 'Type todo name', model: forms['title']),
            LzForm.input(label: 'Description', hint: 'Type todo description', model: forms['description'])
          ],
        ),
    
        bottomNavigationBar: LzButton(
          text: 'Submit',
          onTap: (state) async {
            state.submit();
            bool ok = await notifier.submit(data?.id);
    
            if(ok && context.mounted){
              context.pop();
              LzToast.show(data?.id == null ? 'Todo has been created.' : 'Todo has been updated.');
            }
          },
        ).theme1(),
      ),
    );
  }
}