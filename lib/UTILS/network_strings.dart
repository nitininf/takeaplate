class NetworkStrings {



  /// Frontend Route /////////////////////////////////////////
  static const String SHARE_BASE_URL = "https://beta.syllo.co/";
  //JobWish networkstriing
  // static const String API_BASE_URL_PREV = "https://jobwish.ch/staging/wp-json/jobwish/v1/"; //"https://beta-api.syllo.co/api/";
  // static const String API_BASE_URL = "http://3.145.80.252/api";
  static const String API_BASE_URL = "http://18.220.120.69/api";
  static const String ACCEPT = 'application/json';
  static const String TOKEN_KEY = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2pvYndpc2guY2gvc3RhZ2luZyIsImlhdCI6MTcwMDgwNzEwOSwibmJmIjoxNzAwODA3MTA5LCJleHAiOjE3MDE0MTE5MDksImRhdGEiOnsidXNlciI6eyJpZCI6IjEifX19.Bbj5h7J4XglOyDjESHBssneQhRCofvIKcGpznmEa8w8';



  static const int SUCCESS_CODE = 200;
  static const int BAD_REQUEST_CODE = 400;
  static const int UNAUTHORIZED_CODE = 401;
  static const int FORBIDDEN_CODE = 403;

  /// API MESSAGES /////////////////////////////////////////////////////////
  static const int API_SUCCESS_STATUS = 1;
  static const int EMAIL_UNVERIFIED = 0;
  static const int EMAIL_VERIFIED = 1;
  static const int PROFILE_INCOMPLETED = 0;
  static const int PROFILE_COMPLETED = 1;
  static const String NO_INTERNET_CONNECTION="No Internet Connection!";


  /// APIS END Points //////////////////////////////////////////////////////

  static const String uploadFile="account/file/upload";
  static const String LOG_IN = 'user-login';
  static const String USER_FORGOT_PASSWORD = 'user-forgot-password';
  static const String USER_SIGN_UP = 'user-sign-up';
  static const String USER_UPDATE_PASSWORD = 'user-Update-Password';
  static const String USER_PROFESSIIONAL_DETAIILS = 'user-Professional-Details';
  static const String USER_PROFESSIIONAL_DETAIILS_UPDATES = 'user-Professional-Details-Update';
  static const String JOBS = 'job-lists';
  static const String JOB_APPLY='job-apply';
  static const String JOB_FOR_CANDIDATE='job-for-candidate';
  static const String USER_SUMMERY='user-summary';




}
