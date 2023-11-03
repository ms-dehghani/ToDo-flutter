import 'package:ToDo/src/domain/models/category/category_item.dart';


sealed class CategoryCreateOrUpdateEvent {}

class UpdateUI extends CategoryCreateOrUpdateEvent{}

class CategoryCreateOrUpdateResultEvent extends CategoryCreateOrUpdateEvent{
  CategoryItem catItem;

  CategoryCreateOrUpdateResultEvent(this.catItem);
}
