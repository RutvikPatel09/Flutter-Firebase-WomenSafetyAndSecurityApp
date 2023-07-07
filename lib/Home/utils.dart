import 'package:womensafetyandsecurity/Home/category.dart';
import 'package:womensafetyandsecurity/Home/helper/appColors.dart';
import 'package:womensafetyandsecurity/Home/helper/iconhelper.dart';

class Utils {
  static List<Category> getMockedCategories() {
    return [
      Category(
          name: "Test",
          icon: IconHelper.MEATS,
          color: AppColors.MEATS,
          
          imgName: "harassment"),
      Category(
          name: "Test",
          icon: IconHelper.FRUITS,
          color: AppColors.FRUITS,
          imgName: "harassment"),
      Category(
          name: "Test",
          icon: IconHelper.VEGS,
          color: AppColors.VEGS,
          imgName: "harassment"),
      Category(
          name: "Test",
          icon: IconHelper.SEEDS,
          color: AppColors.SEEDS,
          imgName: "harassment"),
      Category(
          name: "Test",
          icon: IconHelper.SPICES,
          color: AppColors.SPICES,
          imgName: "harassment"),
      Category(
          name: "Test",
          icon: IconHelper.PASTRIES,
          color: AppColors.PASTRIES,
          imgName: "harassment"),
    ];
  }
}
