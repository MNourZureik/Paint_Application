import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ValidatorModel {
  RxString errorMessage;
  RxBool isError;

  ValidatorModel({
    required this.errorMessage,
    required this.isError,
  });
}
