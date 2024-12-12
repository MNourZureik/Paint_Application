import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/modules/forgot_password/presentation/new_password_screen.dart';
import '/modules/forgot_password/presentation/otp_screen.dart';
import '/modules/account/bindings/account_binding.dart';
import '/modules/account/bindings/edit_profile_binding.dart';
import '/modules/account/presentation/edit_profile_screen.dart';
import '/modules/administration_messages/bindings/administration_messages_binding.dart';
import '/modules/administration_messages/bindings/send_message_binding.dart';
import '/modules/administration_messages/presentation/send_message_screen.dart';
import '/modules/bills/bindings/bills_binding.dart';
import '/modules/bills/presentation/bills_screen.dart';
import '/modules/buy_table/bindings/buy_table_binding.dart';
import '/modules/categories/bindings/brochures_binding.dart';
import '/modules/categories/bindings/categories_binding.dart';
import '/modules/categories/bindings/category_binding.dart';
import '/modules/categories/bindings/category_details_binding.dart';
import '/modules/categories/presentation/brochures_screen.dart';
import '/modules/categories/presentation/categories_screen.dart';
import '/modules/categories/presentation/category_details_screen.dart';
import '/modules/categories/presentation/category_screen.dart';
import '/modules/distribution_centres/bindings/distribution_centres_binding.dart';
import '/modules/distribution_centres/presentation/distribution_centres_screen.dart';
import '/modules/edit_password/bindings/edit_password_binding.dart';
import '/modules/edit_password/presentation/edit_password_screen.dart';
import '/modules/favorites/bindings/favorites_binding.dart';
import '/modules/favorites/model/response/favorites_model.dart';
import '/modules/favorites/presentation/favorites_screen.dart';
import '/modules/forgot_password/bindings/forgot_password_binding.dart';
import '/modules/forgot_password/presentation/forgot_password_screen.dart';
import '/modules/home_page/bindings/home_page_binding.dart';
import '/modules/home_page/presentation/home_page_screen.dart';
import '/modules/main_app/bindings/main_App_binding.dart';
import '/modules/main_app/presentation/main_app_screen.dart';
import '/modules/my_gifts/bindings/my_gifts_binding.dart';
import '/modules/my_gifts/presentation/my_gifts_screen.dart';
import '/modules/my_points/bindings/my_points_binding.dart';
import '/modules/my_points/presentation/my_points_screen.dart';
import '/modules/notifications/bindings/notifications_binding.dart';
import '/modules/notifications/presentation/notifications_screen.dart';
import '/modules/product_details/bindings/product_details_binding.dart';
import '/modules/product_details/bindings/product_files_binding.dart';
import '/modules/product_details/presentation/product_details_screen.dart';
import '/modules/product_details/presentation/product_files_screen.dart';
import '/modules/product_list/bindings/product_list_binding.dart';
import '/modules/product_list/presentation/product_list_screen.dart';
import '/modules/product_search/bindings/product_search_binding.dart';
import '/modules/product_search/presentation/product_search_screen.dart';
import '/modules/receipt/bindings/receipt_binding.dart';
import '/modules/receipt/presentation/receipt_screen.dart';
import '/modules/sign_in/bindings/sign_in_binding.dart';
import '/modules/sign_in/presentation/sign_in_screen.dart';
import '/modules/sign_up/bindings/sign_up_binding.dart';
import '/modules/sign_up/bindings/verify_account_binding.dart';
import '/modules/sign_up/presentation/sign_up_screen.dart';
import '/modules/sign_up/presentation/verify_account_screen.dart';
import '/modules/start/bindings/start_binding.dart';
import '/modules/start/presentation/start_screen.dart';
import '../../modules/account/presentation/account_screen.dart';
import '../../modules/buy_table/presentation/buy_table_screen.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/presentation/splash_screen.dart';
import '/modules/administration_messages/presentation/administration_messages_screen.dart';

class AppRouters {
  static String initRoute = '/splash';

  static List<GetPage> PAGES = [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/start',
      page: () => StartScreen(),
      binding: StartBinding(),
    ),
    GetPage(
      name: '/sign_in',
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: '/forgot_password',
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: '/sign_up',
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: '/forgot_password',
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: '/main_app',
      page: () => MainAppScreen(),
      binding: MainAppBinding(),
    ),
    GetPage(
      name: '/home_page',
      page: () => HomePageScreen(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: '/scanner',
      page: () => ReceiptScreen(),
      binding: ReceiptBinding(),
    ),
    GetPage(
      name: '/account',
      page: () => AccountScreen(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: '/product_list',
      page: () => ProductListScreen(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: '/product_details',
      page: () => ProductDetailsScreen(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: '/notifications',
      page: () => NotificationsScreen(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: '/distribution_centres',
      page: () => DistributionCentresScreen(),
      binding: DistributionCentresBinding(),
    ),
    GetPage(
      name: '/administration_messages',
      page: () => AdministrationMessagesScreen(),
      binding: AdministrationMessagesBinding(),
    ),
    GetPage(
      name: '/bills',
      page: () => BillsScreen(),
      binding: BillsBinding(),
    ),
    GetPage(
      name: '/edit_password',
      page: () => EditPasswordScreen(),
      binding: EditPasswordBinding(),
    ),
    GetPage(
      name: '/otp_screen',
      page: () => OtpScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: '/new_password',
      page: () => NewPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: '/buy_table',
      page: () => BuyTableScreen(),
      binding: BuyTableBinding(),
    ),
    GetPage(
      name: '/my_points',
      page: () => MyPointsScreen(),
      binding: MyPointsBinding(),
    ),
    GetPage(
      name: '/favorites',
      page: () => FavoritesScreen(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: '/my_gifts',
      page: () => MyGiftsScreen(),
      binding: MyGiftsBinding(),
    ),
    GetPage(
      name: '/edit_profile',
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: '/verify_account',
      page: () => VerifyAccountScreen(),
      binding: VerifyAccountBinding(),
    ),
    GetPage(
      name: '/send_message',
      page: () => SendMessageScreen(),
      binding: SendMessageBinding(),
    ),
    GetPage(
      name: '/search_products',
      page: () => ProductSearchScreen(),
      binding: ProductSearchBinding(),
    ),
    GetPage(
      name: '/product_files',
      page: () => ProductFilesScreen(),
      binding: ProductFilesBinding(),
    ),
    GetPage(
      name: '/categories',
      page: () => CategoriesScreen(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: '/sub_category',
      page: () => CategoryScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: '/category_details',
      page: () => CategoryDetailsScreen(),
      binding: CategoryDetailsBinding(),
    ),
    GetPage(
      name: '/category_brochures',
      page: () => BrochuresScreen(),
      binding: BrochuresBinding(),
    ),



  ];
}
