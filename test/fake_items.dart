import 'package:faker/faker.dart';
import 'package:ToDo/src/domain/models/category/category_item.dart';
import 'package:ToDo/src/domain/models/priority/priority_item.dart';
import 'package:ToDo/src/domain/models/task/task_item.dart';

TaskItem getFakeTaskItem() {
  var faker = Faker();
  TaskItem taskItem = TaskItem(
      id: faker.lorem.sentence(),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      categoryItem: getFakeCategoryItem(),
      isDone: false,
      priorityItem: getFakePriorityItem(),
      taskTimestamp: DateTime.now().millisecondsSinceEpoch);
  return taskItem;
}

CategoryItem getFakeCategoryItem() {
  var faker = Faker();
  return CategoryItem(faker.lorem.sentence(), faker.lorem.sentence());
}

PriorityItem getFakePriorityItem() {
  var faker = Faker();
  return PriorityItem(faker.lorem.sentence(), faker.lorem.sentence(), "#00000000");
}
