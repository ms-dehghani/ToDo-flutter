// Mocks generated by Mockito 5.4.4 from annotations
// in ToDo/test/src/app/logic/task/create_update/bloc/task_create_update_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:ToDo/src/domain/models/task/task_item.dart' as _i2;
import 'package:ToDo/src/domain/usecase/task/task_usecase.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTaskItem_0 extends _i1.SmartFake implements _i2.TaskItem {
  _FakeTaskItem_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskUseCase extends _i1.Mock implements _i3.TaskUseCase {
  MockTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.TaskItem?> getTaskByID(String? taskID) => (super.noSuchMethod(
        Invocation.method(
          #getTaskByID,
          [taskID],
        ),
        returnValue: _i4.Future<_i2.TaskItem?>.value(),
      ) as _i4.Future<_i2.TaskItem?>);

  @override
  _i4.Future<_i2.TaskItem> createOrUpdateTask(_i2.TaskItem? taskItem) =>
      (super.noSuchMethod(
        Invocation.method(
          #createOrUpdateTask,
          [taskItem],
        ),
        returnValue: _i4.Future<_i2.TaskItem>.value(_FakeTaskItem_0(
          this,
          Invocation.method(
            #createOrUpdateTask,
            [taskItem],
          ),
        )),
      ) as _i4.Future<_i2.TaskItem>);

  @override
  _i4.Future<List<_i2.TaskItem>> getTaskListFromData(int? timestamp) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTaskListFromData,
          [timestamp],
        ),
        returnValue: _i4.Future<List<_i2.TaskItem>>.value(<_i2.TaskItem>[]),
      ) as _i4.Future<List<_i2.TaskItem>>);

  @override
  _i4.Future<List<_i2.TaskItem>> getAllTasks() => (super.noSuchMethod(
        Invocation.method(
          #getAllTasks,
          [],
        ),
        returnValue: _i4.Future<List<_i2.TaskItem>>.value(<_i2.TaskItem>[]),
      ) as _i4.Future<List<_i2.TaskItem>>);

  @override
  _i4.Future<Map<int, bool>> isAnyTaskExistInRange(
    int? fromTimestamp,
    int? endTimestamp,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #isAnyTaskExistInRange,
          [
            fromTimestamp,
            endTimestamp,
          ],
        ),
        returnValue: _i4.Future<Map<int, bool>>.value(<int, bool>{}),
      ) as _i4.Future<Map<int, bool>>);

  @override
  _i4.Future<bool> isAnyTaskExistInDate(int? date) => (super.noSuchMethod(
        Invocation.method(
          #isAnyTaskExistInDate,
          [date],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> deleteTask(String? taskID) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [taskID],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<void> clear() => (super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
