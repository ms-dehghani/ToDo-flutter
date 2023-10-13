import 'package:kardone/src/model/items/tasks/category/pojo/category_item.dart';


sealed class CategoryCreateOrUpdateEvent {}

class UpdateUI extends CategoryCreateOrUpdateEvent{}

class CategoryCreateOrUpdateResultEvent extends CategoryCreateOrUpdateEvent{
  CategoryItem catItem;

  CategoryCreateOrUpdateResultEvent(this.catItem);
}
