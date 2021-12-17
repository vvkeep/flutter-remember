import 'package:event_bus/event_bus.dart';
import 'package:iron_box/model/item_model.dart';

EventBus eventBus = EventBus();

class CategoryListEvent {}

class CategoryEvent {
  CategoryModel category;

  CategoryEvent(this.category);
}

class ItemEvent {}
