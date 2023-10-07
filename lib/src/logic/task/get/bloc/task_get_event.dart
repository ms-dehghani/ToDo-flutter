
sealed class TaskGetEvent {}

class GetAllTaskInDayEvent extends TaskGetEvent {
  int dayTimestamp;

  GetAllTaskInDayEvent(this.dayTimestamp);
}

class GetAllTaskInCalenderEvent extends TaskGetEvent {
  int startTime, endTime;

  GetAllTaskInCalenderEvent({required this.startTime, required this.endTime});
}

class RefreshTaskListEvent extends GetAllTaskInDayEvent {
  RefreshTaskListEvent(super.dayTimestamp);
}


class GetTask extends TaskGetEvent {
  String taskID;

  GetTask(this.taskID);
}
