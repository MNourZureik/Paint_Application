class APIUrls {
  static const BASE_URL = "https://aecmobile.com";
  //static const BASE_URL = "http://192.168.1.117:8888";
  static const IMAGE_BASE_URL = "";

  /// for api call , we define section like this:

  /// auth
  static const signIn = "/api/login";
  static const signUp = "/api/register";
  static const appVersion = "/api/check-version";
  static const currentCampaign = "/api/current_campaign";
  static const checkAuth = "/api/check_token";
  static const getProducts = "/api/products";
  static const getProduct = "/api/product";
  static const changePassword = "/api/changePassword";
  static const forgotPassword = "/api/forgot-password";
  static const fcmToken = "/api/deviceToken";
  static const verifyCode = "/api/verify-code";
  static const resetPassword = "/api/reset-password";
  static const getFavorites = "/api/favorites";
  static const updateFavorite = "/api/favorite";
  static const getDistributors = "/api/distributors";
  static const getBills = "/api/bills_app1";
  static const getDistBills = "/api/bills_app1_sales";
  static const getGifts = "/api/gifts";
  static const getPoints = "/api/points";
  static const getOnlyDist = "/api/onlyDistributors";
  static const getCities = "/api/cities";
  static const editProfile = "/api/profile";
  static const verifyAccount = "/api/codeVerify";
  static const getMessages = "/api/messages";
  static const getMyGifts = "/api/mygifts";
  static const getNotifications = "/api/notifications";
  static const reSendCode = "/api/resendCode";
  static const claim = "/api/claim";
  static const sendMessageByMember = "/api/sendmessageByMember";
  static const sendMessageByGuest = "/api/sendMessageByGuest";
  static const getCategories = "/api/categories";
  static const getCategory = "/api/category";
  static const getCategoryDetails = "/api/category_details";
  static const getUserMessages = "/api/get_memebers_messages";
  static const deleteBill = "/api/delete_bill";

/* testApi() async {
    var response = await _apiRepo.requestApi(
      method: POST,
      url: APIUrls.EXAMPL_API_NAME,
      data: {

      }
    );
    print(response.success);
    print(response.error);
    print(response.status);
    print(response.data);
  }*/

/*Future<void> testAPICall(parameters) async {
    var url = APIUrls.publicDomainAddress + ;
    var response = await APIUrls.client.get(Uri.parse(url), headers: ,);

    print(response.statusCode);
    print(response.body);
    var jsonResponse = response.body;
    var responseMsg = toJson(jsonResponse);
    if( response.statusCode == 200){
      return responseMsg;
    }
    else{
      error = '';
      return ProductByCategory();
    }


  }
   */
}
