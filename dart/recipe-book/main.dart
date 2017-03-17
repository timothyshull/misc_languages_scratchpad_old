library recipe_book;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';

import './lib/component/rating.dart';
import './lib/component/recipe_book.dart';

class MyAppModule extends Module {
  MyAppModule() {
    bind(RecipeBookComponent);
    bind(RatingComponent);
  }
}

void main() {
  applicationFactory()
  .addModule(new MyAppModule())
  .run();
}