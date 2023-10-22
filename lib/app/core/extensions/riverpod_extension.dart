import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// AutoDisposeStateNotifierProvider<AdditionExerciseNotifier, ExerciseState>

extension CustomExtension<NotifierT extends StateNotifier<StateT>, StateT>
    on StateNotifierProvider<NotifierT, StateT> {
  /// Create a widget that watches the state provided by [StateNotifierProvider] and rebuilds when it changes.
  /// This extension simplifies the process of watching the provider's state and building widgets based on its value.
  ///
  /// ```dart
  /// myStateProvider.watch((value) {
  ///   return Text('Generated: ${value.randomName}');
  /// })
  /// ```

  Widget watch(
    Widget Function(StateT value) builder,
  ) {
    return Consumer(
      builder: (context, ref, _) {
        final value = ref.watch(this);
        return builder(value);
      },
    );
  }
}

extension AutoDisposeStateNotifierProviderExtension<T>
    on AutoDisposeStateNotifierProvider<StateNotifier<T>, T> {
  /// This extension is used to watch the state of an AutoDisposeStateNotifierProvider
  ///
  /// ``` dart
  /// myAutoDisposeProvider.watch((value){
  ///   return value.when(
  ///     data: (data) => ListWidget(data),
  ///     loading: () => LoadingWidget(),
  ///     error: (error, stack) => ErrorWidget(error),
  ///   );
  /// })
  /// ```
  ///

  Widget watch(Widget Function(T value) builder) {
    return Consumer(
      builder: (context, ref, _) {
        final asyncData = ref.watch(this);
        return builder(asyncData);
      },
    );
  }
}

// extension AsyncAutoDisposeStateNotifierProviderExtension<T> on AutoDisposeStateNotifierProvider<
//     StateNotifier<AsyncValue<T>>, AsyncValue<T>> {
//   /// ```dart
//   /// autoDisposeProvider.watch<bool>((value) {
//   ///   return IconButton(
//   ///     icon: const Icon(Ti.checks),
//   ///     onPressed: !value ? null : () {
//   ///       // do something...
//   ///     }
//   ///   ).opacity(value ? 1 : .3);
//   /// })
//   /// ```

//   Widget watch<E>(
//     Widget Function(E value) builder,
//   ) {
//     return Consumer(
//       builder: (context, ref, _) {
//         final asyncData = ref.watch(this);

//         if (E == bool) {
//           return asyncData.maybeWhen(
//             data: (_) => builder(true as E),
//             orElse: () => builder(false as E),
//           );
//         }

//         return asyncData.maybeWhen(
//           data: (_) => builder(_ as E),
//           orElse: () => const SizedBox(),
//         );
//       },
//     );
//   }
// }
