import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/core/app_colors.dart';
import '/modules/administration_messages/presentation/administration_messages_screen.dart';
import '/modules/administration_messages/presentation/send_message_screen.dart';
import '/modules/buy_table/presentation/buy_table_screen.dart';
import '/modules/categories/presentation/brochures_screen.dart';
import '/modules/categories/presentation/categories_screen.dart';
import '/modules/categories/presentation/category_details_screen.dart';
import '/modules/categories/presentation/category_details_state.dart';
import '/modules/product_list/presentation/product_list_screen.dart';
import '/modules/sign_up/presentation/sign_up_screen.dart';
import '/modules/sign_up/presentation/verify_account_screen.dart';

import '../modules/account/presentation/edit_profile_screen.dart';
import '../modules/categories/presentation/category_screen.dart';
import '../modules/notifications/presentation/notifications_screen.dart';

getWaitingWidget(String key){
  switch(key){
    case "loading_button":{
      break;
    }
    case EditProfileScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case SignUpScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case VerifyAccountScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case AdministrationMessagesScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case ProductListScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case BuyTableScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case NotificationsScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case SendMessageScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case CategoriesScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case CategoryDetailsScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case CategoryScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    case BrochuresScreen.pageIdentifier:{
      return getCircularWaitingWidget();
    }
    casedefault:{
      return;
    }
  }

}

Widget getCircularWaitingWidget(){
  if(Platform.isIOS){
    return const Center(child: CupertinoActivityIndicator(animating: true,color: AppColors.greenTextColor,),);
  }else{
    return const Center(child: CircularProgressIndicator(color: AppColors.greenTextColor,),);
  }
}