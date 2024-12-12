
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/net/response/base_response.dart';
import '/modules/bills/model/request/delete_bill_params.dart';
import '/modules/bills/model/response/bills.dart';
import '/modules/bills/model/response/dist_bills.dart';
import '../services/bills_service.dart';
import '../presentation/bills_state.dart';

class BillsController extends GetxController {
  final _service = BillsService();
  double aspectRatio=.8;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Rx<BillsState> pageState = BillsState.loading.obs;
  late BaseResponse baseResponse;
  late Rx<Bills> bills = Rx<Bills>(Bills(bills: []));
  var noBills=false.obs;
  @override
  void onReady() async{
    pageState.value=BillsState.loading;
    await getBills();
    pageState.value=BillsState.initial;
    super.onReady();
  }

  getBills() async{
    baseResponse=await _service.getBills();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        bills=Bills.fromJson(baseResponse.data).obs;
        if(bills.value==null||bills.value.bills!.isEmpty){
          noBills(true);
        }
      }
    }
  }

  void deleteBill(int id) async{
    DeleteBillParams deleteBillParams=DeleteBillParams(id: id);
    baseResponse=await _service.deleteBill(deleteBillParams);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        if(baseResponse.success==true){
          Fluttertoast.showToast(
              msg: "تم حذف الفاتورة بنجاح",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0
          );
          await getBills();
        }
      }
    }
  }

}
