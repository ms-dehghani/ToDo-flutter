sealed class TaskListEvent {}

class GetAllTaskInDayEvent extends TaskListEvent {
  int dayTimestamp;

  GetAllTaskInDayEvent(this.dayTimestamp);
}

class GetAllTaskInCalenderEvent extends TaskListEvent {
  int startTime, endTime;

  GetAllTaskInCalenderEvent({required this.startTime, required this.endTime});
}

class GetAllTaskEvent extends TaskListEvent {}

class RefreshTaskListEvent extends GetAllTaskInDayEvent {
  RefreshTaskListEvent(super.dayTimestamp);
}
