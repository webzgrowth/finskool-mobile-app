// ignore_for_file: constant_identifier_names


class AppRoutes {
  // Splash routes
  static const String SPLASH_ROUTE_NAME = 'splash';
  static const String SPLASH_ROUTE_PATH = '/';

  // Authentications routes
  static const String ONBOARDING_ROUTE_NAME = 'onboarding';
  static const String ONBOARDING_ROUTE_PATH = '/onboarding';

  static const String LOGIN_ROUTE_NAME = 'login';
  static const String LOGIN_ROUTE_PATH = '/login';

  static const String SIGNUP_ROUTE_NAME = 'signup';
  static const String SIGNUP_ROUTE_PATH = '/signup';

  // Password reset routes
  static const String RESET_PASSWORD_ROUTE_NAME = 'reset-password';
  static const String RESET_PASSWORD_ROUTE_PATH = '/reset-password';

  static const String VERIFY_RESET_CODE_ROUTE_NAME = 'verify-reset-code';
  static const String VERIFY_RESET_CODE_ROUTE_PATH = '/reset-password/verify';

  static const String NEW_PASSWORD_ROUTE_NAME = 'new-password';
  static const String NEW_PASSWORD_ROUTE_PATH = '/reset-password/new';

  static const String PASSWORD_RESET_SUCCESS_ROUTE_NAME =
      'password-reset-success';
  static const String PASSWORD_RESET_SUCCESS_ROUTE_PATH =
      '/reset-password/success';

  // Signup verification routes
  static const String VERIFY_PHONE_ROUTE_NAME = 'verify-phone';
  static const String VERIFY_PHONE_ROUTE_PATH = '/signup/verify-phone';

  static const String VERIFY_EMAIL_ROUTE_NAME = 'verify-email';
  static const String VERIFY_EMAIL_ROUTE_PATH = '/signup/verify-email';

  static const String GOOGLE_LAST_STEP_ROUTE_NAME = 'google-last-step';
  static const String GOOGLE_LAST_STEP_ROUTE_PATH = '/signup/google-last-step';

  static const String SIGNUP_SUCCESS_ROUTE_NAME = 'signup-success';
  static const String SIGNUP_SUCCESS_ROUTE_PATH = '/signup/success';

  //current location route
  static const String CURRENT_LOCATION_ROUTE_NAME = 'current-location';
  static const String CURRENT_LOCATION_ROUTE_PATH = '/current-location';

  // Dashboard routes
  static const String DASHBOARD_ROUTE_NAME = 'dashboard';
  static const String DASHBOARD_ROUTE_PATH = '/dashboard';

  static const String HOME_ROUTE_NAME = "Home";
  static const String HOME_ROUTE_PATH = "/home";

  static const String PROFILE_ROUTE_NAME = "Profile";
  static const String PROFILE_ROUTE_PATH = "/profile";

  // Profile routes

  static const String EDIT_PROFILE_ROUTE_NAME = "edit-profile";
  static const String EDIT_PROFILE_ROUTE_PATH = "edit-profile";

  static const String SHIPPING_ROUTE_NAME = "MyShipping";
  static const String SHIPPING_ROUTE_PATH = "/shipping";

  static const String TERM_OF_USE_ROUTE_NAME = "term-of-use";
  static const String TERM_OF_USE_ROUTE_PATH = "/term-of-use";

  static const String PRIVACY_ROUTE_NAME = "privacy-policy";
  static const String PRIVACY_ROUTE_PATH = "/privacy-policy";

  // send package routes

  static const String SEND_PACKAGE_ROUTE_NAME = "send-package";
  static const String SEND_PACKAGE_ROUTE_PATH = "/send-package";

  // stripe routes
  static const String STRIPE_PAYMENT_ROUTE_NAME = "stripe";
  static const String STRIPE_PAYMENT_ROUTE_PATH = "/stripe";

  // location route
  static const String SAVED_ADDRESS_ROUTE_NAME = "saved-adddress";
  static const String SAVED_ADDRESS_ROUTE_PATH = "/saved-address";

  static const String ADD_ADDRESS_ROUTE_NAME = "add_saved-adddress";
  static const String ADD_ADDRESS_ROUTE_PATH = "add-saved-address";

  static const String LOCATION_SEARCH_ROUTE_NAME = "location-search";
  static const String LOCATION_SEARCH_ROUTE_PATH = "location-search";

  static const String PICK_DROP_ROUTE_NAME = "pick-drop-address";
  static const String PICK_DROP_ROUTE_PATH = "pick-drop-address";

  static const String PICK_DROP_DETAILS_ROUTE_NAME =
      "pick-drop-details-address";
  static const String PICK_DROP_DETAILS_ROUTE_PATH =
      "pick-drop-details-address";



  // Coupons & offers
  static const String COUPON_OFFERS_ROUTE_NAME = "coupon-offer";
  static const String COUPON_OFFERS_ROUTE_PATH = "/coupon-offer";

  //Transactions
  static const String VIEW_ALL_TRANSACTIONS_ROUTE_NAME = "view-transactions";
  static const String VIEW_ALL_TRANSACTIONS_ROUTE_PATH = "/view-transactions";

  // Rider review
  static const String RIDER_REVIEW_ROUTE_NAME = "rider-review";
  static const String RIDER_REVIEW_ROUTE_PATH = "/rider-review";

  ///----------------------------------------------------
  ///------------------ Handyman Routes------------------
  ///----------------------------------------------------

  //Homescreen
  static const String HANDYMAN_HOME_SCREEN_ROUTE_NAME = "handyman-home";
  static const String HANDYMAN_HOME_SCREEN_ROUTE_PATH = "/handyman-home";

  //Select Location routes
  static const String HANDYMAN_LOCATION_ROUTE_NAME = "handyman-location";
  static const String HANDYMAN_LOCATION_ROUTE_PATH = "/handyman-location";

  //Service details routes
  static const String HANDYMAN_SERVICE_DETAILS_ROUTE_NAME =
      "handyman-service-details";
  static const String HANDYMAN_SERVICE_DETAILS_ROUTE_PATH =
      "/handyman-service-details";

  //Booking and Scheduling routes
  static const String HANDYMAN_BOOKING_AND_SCHEDULING_ROUTE_NAME =
      "handyman-booking";
  static const String HANDYMAN_BOOKING_AND_SCHEDULING_ROUTE_PATH =
      "/handyman-booking";

  //Booking Summary routes
  static const String HANDYMAN_BOOKING_SUMMARY_ROUTE_NAME =
      "handyman-booking-summary";
  static const String HANDYMAN_BOOKING_SUMMARY_ROUTE_PATH =
      "/handyman-booking-summary";

  //Pickup Details routess
  static const String HANDYMAN_PICKUP_DETAILS_ROUTE_NAME =
      "handyman-pickup-details";
  static const String HANDYMAN_PICKUP_DETAILS_ROUTE_PATH =
      "/handyman-pickup-details";

  //Handyman review routes
  static const String HANDYMAN_REVIEW_ROUTE_NAME =
      "handyman-review";
  static const String HANDYMAN_REVIEW_ROUTE_PATH =
      "/handyman-review";
}
