import 'package:event_bus/event_bus.dart';
import 'package:remember/model/item_model.dart';

EventBus eventBus = new EventBus();

class CategoryListEvent {}

class CategoryEvent {
  RMCategoryModel category;

  CategoryEvent(this.category);
}
