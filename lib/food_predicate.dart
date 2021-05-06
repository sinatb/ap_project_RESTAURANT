import 'package:models/models.dart';

class FoodPredicate {
  String? name;
  bool availability = true;
  String? lowerPrice;
  String? upperPrice;

  bool Function(Food) generate() {

    int lowerPriceInt = int.tryParse(lowerPrice ?? 'm') ?? 1;
    int upperPriceInt = int.tryParse(upperPrice ?? 'm') ?? Price.MAX;
    return (Food food) {
      return food.name.contains(name ?? '') &&
          (food.isAvailable == availability) &&
          (food.price.toInt() >= lowerPriceInt) &&
          (food.price.toInt() <= upperPriceInt);
    };
  }

}