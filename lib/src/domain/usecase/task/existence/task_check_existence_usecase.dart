import 'package:ToDo/src/domain/repositories/task/existence/task_check_existence_repository.dart';

class TaskCheckExistenceUseCase {
  late final TaskCheckExistenceRepository _repository;

  TaskCheckExistenceUseCase(
      {required TaskCheckExistenceRepository repository}) {
    _repository = repository;
  }

  Future<Map<int, bool>> invoke(int startDate, int endDate) {
    return _repository.isAnyTaskExistInRange(startDate, endDate);
  }
}
