import 'package:get/get.dart';

//getx controller class for state management of chips

class ChipController extends GetxController {
  var _selectedChip = 0.obs;
  get selectedChip => this._selectedChip.value;
  set selectedChip(index) => this._selectedChip.value = index;
}