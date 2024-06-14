abstract class TaskCheckExistenceRepository {
  Future<Map<int, bool>> isAnyTaskExistInRange(
      int fromTimestamp, int endTimestamp);
}
