import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../core/app_colors.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int? selectedIndex;
  final List<PersistentBottomNavBarItem>?
      items; // NOTE: You CAN declare your own model here instead of `PersistentBottomNavBarItem`.
  final ValueChanged<int>? onItemSelected;

  CustomNavBarWidget({
    this.selectedIndex,
    @required this.items,
    this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.upperNavBarBackgroundColor,
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Container(
              width:50,
              child: IconTheme(
                data: IconThemeData(
                    size: 26.0,
                    color: isSelected
                        ? AppColors.selectedNavBarItem
                        : AppColors.unSelectedNavBarItem),
                child: item.icon,
              ),
            ),
          ),
          Text(
            "${item.title}".tr,
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: "BahijBold",
              color: isSelected
                  ? AppColors.selectedNavBarItem
                  : AppColors.unSelectedNavBarItem
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10)),
        ),
        child: Container(
          width: double.infinity,
          height: 75.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items!.map((item) {
              int index = items!.indexOf(item);
              return Flexible(
                child: GestureDetector(
                  onTap: () {
                    onItemSelected!(index);
                  },
                  child: _buildItem(item, selectedIndex == index,),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
