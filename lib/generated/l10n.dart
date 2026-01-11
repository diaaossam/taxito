// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Taxito`
  String get appName {
    return Intl.message('Taxito', name: 'appName', desc: '', args: []);
  }

  /// `This field is required`
  String get validation {
    return Intl.message(
      'This field is required',
      name: 'validation',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `An error occurred!`
  String get thereIsError {
    return Intl.message(
      'An error occurred!',
      name: 'thereIsError',
      desc: '',
      args: [],
    );
  }

  /// `Uploading...`
  String get uploading {
    return Intl.message('Uploading...', name: 'uploading', desc: '', args: []);
  }

  /// `Pick video`
  String get pickVideo {
    return Intl.message('Pick video', name: 'pickVideo', desc: '', args: []);
  }

  /// `Pick Image`
  String get pickImage {
    return Intl.message('Pick Image', name: 'pickImage', desc: '', args: []);
  }

  /// `Choose Image`
  String get chooseFromGallery1 {
    return Intl.message(
      'Choose Image',
      name: 'chooseFromGallery1',
      desc: '',
      args: [],
    );
  }

  /// `Choose video`
  String get chooseFromGallery2 {
    return Intl.message(
      'Choose video',
      name: 'chooseFromGallery2',
      desc: '',
      args: [],
    );
  }

  /// `Choose From Gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose From Gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `I Agree with`
  String get iAgreeWith {
    return Intl.message('I Agree with', name: 'iAgreeWith', desc: '', args: []);
  }

  /// `terms`
  String get terms {
    return Intl.message('terms', name: 'terms', desc: '', args: []);
  }

  /// `conditions`
  String get conditions {
    return Intl.message('conditions', name: 'conditions', desc: '', args: []);
  }

  /// `and`
  String get and {
    return Intl.message('and', name: 'and', desc: '', args: []);
  }

  /// `terms and conditions`
  String get termsAndConditions {
    return Intl.message(
      'terms and conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'privacy policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message('Continue', name: 'continueText', desc: '', args: []);
  }

  /// `Choose your lang`
  String get chooseYourLang {
    return Intl.message(
      'Choose your lang',
      name: 'chooseYourLang',
      desc: '',
      args: [],
    );
  }

  /// `User Suggestions`
  String get userSuggestions {
    return Intl.message(
      'User Suggestions',
      name: 'userSuggestions',
      desc: '',
      args: [],
    );
  }

  /// `We would love to know your suggestions! Please tell us how we can make Marriage Story better for you`
  String get suggestionBody {
    return Intl.message(
      'We would love to know your suggestions! Please tell us how we can make Marriage Story better for you',
      name: 'suggestionBody',
      desc: '',
      args: [],
    );
  }

  /// `Choose the type of Suggestion`
  String get chooseSuggestion {
    return Intl.message(
      'Choose the type of Suggestion',
      name: 'chooseSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Enter the message`
  String get enterMessage {
    return Intl.message(
      'Enter the message',
      name: 'enterMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Write your message here`
  String get enterMessageHere {
    return Intl.message(
      'Write your message here',
      name: 'enterMessageHere',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Faq`
  String get faq {
    return Intl.message('Faq', name: 'faq', desc: '', args: []);
  }

  /// `Premium`
  String get distinguished {
    return Intl.message('Premium', name: 'distinguished', desc: '', args: []);
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `Chats`
  String get chats {
    return Intl.message('Chats', name: 'chats', desc: '', args: []);
  }

  /// `My Account`
  String get myAccount {
    return Intl.message('My Account', name: 'myAccount', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `App Language`
  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Continue with`
  String get continueWith {
    return Intl.message(
      'Continue with',
      name: 'continueWith',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get wrongPhoneNumber {
    return Intl.message(
      'Invalid phone number',
      name: 'wrongPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get newRegister {
    return Intl.message('Register', name: 'newRegister', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Please try again later`
  String get tryAgainLater {
    return Intl.message(
      'Please try again later',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `Send Report`
  String get sendReport {
    return Intl.message('Send Report', name: 'sendReport', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Login data`
  String get loginData {
    return Intl.message('Login data', name: 'loginData', desc: '', args: []);
  }

  /// `Update my profile`
  String get profileUpdate {
    return Intl.message(
      'Update my profile',
      name: 'profileUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message('Full name', name: 'fullName', desc: '', args: []);
  }

  /// `Personal information must be written accurately because it cannot be modified except with the approval of the administration within 24 hours`
  String get registerBody1 {
    return Intl.message(
      'Personal information must be written accurately because it cannot be modified except with the approval of the administration within 24 hours',
      name: 'registerBody1',
      desc: '',
      args: [],
    );
  }

  /// `There is no data on this page`
  String get noDataHere {
    return Intl.message(
      'There is no data on this page',
      name: 'noDataHere',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to `
  String get welcomeTitle {
    return Intl.message(
      'Welcome to ',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose the service type you want to work with: taxi driver or delivery driver, and start your journey with Taxito`
  String get welcomeBody {
    return Intl.message(
      'Choose the service type you want to work with: taxi driver or delivery driver, and start your journey with Taxito',
      name: 'welcomeBody',
      desc: '',
      args: [],
    );
  }

  /// `Create new account`
  String get createNewAccount {
    return Intl.message(
      'Create new account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login as guest`
  String get loginAsGuest {
    return Intl.message(
      'Login as guest',
      name: 'loginAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number to login`
  String get loginBody {
    return Intl.message(
      'Enter your phone number to login',
      name: 'loginBody',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to`
  String get loginTitle {
    return Intl.message('Welcome to', name: 'loginTitle', desc: '', args: []);
  }

  /// `Taxito!`
  String get loginTitle2 {
    return Intl.message('Taxito!', name: 'loginTitle2', desc: '', args: []);
  }

  /// `Or login with`
  String get orLoginWith {
    return Intl.message(
      'Or login with',
      name: 'orLoginWith',
      desc: '',
      args: [],
    );
  }

  /// `Login with Apple`
  String get loginWithApple {
    return Intl.message(
      'Login with Apple',
      name: 'loginWithApple',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent!`
  String get enterVerification {
    return Intl.message(
      'Verification code sent!',
      name: 'enterVerification',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to your phone number: `
  String get verificationCode {
    return Intl.message(
      'Enter the code sent to your phone number: ',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get sendCode {
    return Intl.message('Send code', name: 'sendCode', desc: '', args: []);
  }

  /// `You can request a new code in `
  String get dontReceiveCode {
    return Intl.message(
      'You can request a new code in ',
      name: 'dontReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resendCode {
    return Intl.message('Resend', name: 'resendCode', desc: '', args: []);
  }

  /// `Complete your profile and enjoy a premium experience!`
  String get registerTitle {
    return Intl.message(
      'Complete your profile and enjoy a premium experience!',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the data to create a new account`
  String get registerBody {
    return Intl.message(
      'Fill in the data to create a new account',
      name: 'registerBody',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Governorate`
  String get governorate {
    return Intl.message('Governorate', name: 'governorate', desc: '', args: []);
  }

  /// `Region`
  String get region {
    return Intl.message('Region', name: 'region', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `My Account`
  String get account {
    return Intl.message('My Account', name: 'account', desc: '', args: []);
  }

  /// `Current Location`
  String get currentLocation {
    return Intl.message(
      'Current Location',
      name: 'currentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Main Categories`
  String get mainCategories {
    return Intl.message(
      'Main Categories',
      name: 'mainCategories',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showMore {
    return Intl.message('Show All', name: 'showMore', desc: '', args: []);
  }

  /// `Addresses`
  String get address {
    return Intl.message('Addresses', name: 'address', desc: '', args: []);
  }

  /// `Add new address`
  String get addNewAddress {
    return Intl.message(
      'Add new address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Pick location on map`
  String get pickLocationOnMap {
    return Intl.message(
      'Pick location on map',
      name: 'pickLocationOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Write a note`
  String get notes {
    return Intl.message('Write a note', name: 'notes', desc: '', args: []);
  }

  /// `Save address`
  String get saveLocation {
    return Intl.message(
      'Save address',
      name: 'saveLocation',
      desc: '',
      args: [],
    );
  }

  /// `Location selected successfully`
  String get locationPickedSuccessFully {
    return Intl.message(
      'Location selected successfully',
      name: 'locationPickedSuccessFully',
      desc: '',
      args: [],
    );
  }

  /// `Please select your current location first`
  String get pickerValidation {
    return Intl.message(
      'Please select your current location first',
      name: 'pickerValidation',
      desc: '',
      args: [],
    );
  }

  /// `No saved addresses`
  String get noLocation {
    return Intl.message(
      'No saved addresses',
      name: 'noLocation',
      desc: '',
      args: [],
    );
  }

  /// `IQD`
  String get iqd {
    return Intl.message('IQD', name: 'iqd', desc: '', args: []);
  }

  /// `Best Sellers`
  String get mostSelling {
    return Intl.message(
      'Best Sellers',
      name: 'mostSelling',
      desc: '',
      args: [],
    );
  }

  /// `Special Offers`
  String get specialOffers {
    return Intl.message(
      'Special Offers',
      name: 'specialOffers',
      desc: '',
      args: [],
    );
  }

  /// `New Arrivals`
  String get latest {
    return Intl.message('New Arrivals', name: 'latest', desc: '', args: []);
  }

  /// `Recommended Products`
  String get recommended {
    return Intl.message(
      'Recommended Products',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message('Discount', name: 'discount', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Remaining`
  String get remaining {
    return Intl.message('Remaining', name: 'remaining', desc: '', args: []);
  }

  /// `Choose color`
  String get chooseColor {
    return Intl.message(
      'Choose color',
      name: 'chooseColor',
      desc: '',
      args: [],
    );
  }

  /// `Choose size`
  String get chooseSize {
    return Intl.message('Choose size', name: 'chooseSize', desc: '', args: []);
  }

  /// `Product Specifications`
  String get productSpecifications {
    return Intl.message(
      'Product Specifications',
      name: 'productSpecifications',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message('Add to cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Filter Results`
  String get filterResult {
    return Intl.message(
      'Filter Results',
      name: 'filterResult',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Brand`
  String get brand {
    return Intl.message('Brand', name: 'brand', desc: '', args: []);
  }

  /// `Skin problem`
  String get skinProblem {
    return Intl.message(
      'Skin problem',
      name: 'skinProblem',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Minimum price`
  String get minPrice {
    return Intl.message('Minimum price', name: 'minPrice', desc: '', args: []);
  }

  /// `Maximum price`
  String get maxPrice {
    return Intl.message('Maximum price', name: 'maxPrice', desc: '', args: []);
  }

  /// `Apply search`
  String get applySearch {
    return Intl.message(
      'Apply search',
      name: 'applySearch',
      desc: '',
      args: [],
    );
  }

  /// `No search results found`
  String get noSearchResult {
    return Intl.message(
      'No search results found',
      name: 'noSearchResult',
      desc: '',
      args: [],
    );
  }

  /// `Don't miss these options`
  String get recomndedProduct {
    return Intl.message(
      'Don\'t miss these options',
      name: 'recomndedProduct',
      desc: '',
      args: [],
    );
  }

  /// `Benefits`
  String get benefits {
    return Intl.message('Benefits', name: 'benefits', desc: '', args: []);
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message('Ingredients', name: 'ingredients', desc: '', args: []);
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Suitable for`
  String get suitable_for {
    return Intl.message(
      'Suitable for',
      name: 'suitable_for',
      desc: '',
      args: [],
    );
  }

  /// `No products in cart`
  String get noCart {
    return Intl.message(
      'No products in cart',
      name: 'noCart',
      desc: '',
      args: [],
    );
  }

  /// `Place order`
  String get placeOrder {
    return Intl.message('Place order', name: 'placeOrder', desc: '', args: []);
  }

  /// `Edit profile information`
  String get editProfileInfo {
    return Intl.message(
      'Edit profile information',
      name: 'editProfileInfo',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message('Orders', name: 'orders', desc: '', args: []);
  }

  /// `Points`
  String get points {
    return Intl.message('Points', name: 'points', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Favorites list`
  String get favourites {
    return Intl.message(
      'Favorites list',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `Technical support`
  String get technicalSupport {
    return Intl.message(
      'Technical support',
      name: 'technicalSupport',
      desc: '',
      args: [],
    );
  }

  /// `Sales department`
  String get salesDepartment {
    return Intl.message(
      'Sales department',
      name: 'salesDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Secondary page`
  String get secondaryPage {
    return Intl.message(
      'Secondary page',
      name: 'secondaryPage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Save changes`
  String get saveUpdates {
    return Intl.message(
      'Save changes',
      name: 'saveUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this phone number is already registered`
  String get phoneAlready {
    return Intl.message(
      'Sorry, this phone number is already registered',
      name: 'phoneAlready',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? By deleting it, you will lose your profile, messages and photos permanently.`
  String get deleteAccountBody {
    return Intl.message(
      'Are you sure you want to delete your account? By deleting it, you will lose your profile, messages and photos permanently.',
      name: 'deleteAccountBody',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Please insert a profile picture first`
  String get noImageFound {
    return Intl.message(
      'Please insert a profile picture first',
      name: 'noImageFound',
      desc: '',
      args: [],
    );
  }

  /// `Do you have a discount code?`
  String get doYouHaveDiscount {
    return Intl.message(
      'Do you have a discount code?',
      name: 'doYouHaveDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Enter coupon code`
  String get doYouHaveDiscountHint {
    return Intl.message(
      'Enter coupon code',
      name: 'doYouHaveDiscountHint',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Address`
  String get address1 {
    return Intl.message('Address', name: 'address1', desc: '', args: []);
  }

  /// `Payment method`
  String get paymentType {
    return Intl.message(
      'Payment method',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cash {
    return Intl.message('Cash on delivery', name: 'cash', desc: '', args: []);
  }

  /// `Do you want to add a note?`
  String get addNote {
    return Intl.message(
      'Do you want to add a note?',
      name: 'addNote',
      desc: '',
      args: [],
    );
  }

  /// `Write a note`
  String get addNoteHint {
    return Intl.message(
      'Write a note',
      name: 'addNoteHint',
      desc: '',
      args: [],
    );
  }

  /// `You will earn`
  String get youWillWin {
    return Intl.message(
      'You will earn',
      name: 'youWillWin',
      desc: '',
      args: [],
    );
  }

  /// `points from this order`
  String get youWillWin2 {
    return Intl.message(
      'points from this order',
      name: 'youWillWin2',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice {
    return Intl.message('Invoice', name: 'invoice', desc: '', args: []);
  }

  /// `Subtotal`
  String get total {
    return Intl.message('Subtotal', name: 'total', desc: '', args: []);
  }

  /// `Shipping cost`
  String get shippingCost {
    return Intl.message(
      'Shipping cost',
      name: 'shippingCost',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get totalPrice {
    return Intl.message('Total', name: 'totalPrice', desc: '', args: []);
  }

  /// `Continue shopping`
  String get continueShopping {
    return Intl.message(
      'Continue shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Go to cart`
  String get goToCart {
    return Intl.message('Go to cart', name: 'goToCart', desc: '', args: []);
  }

  /// `Notify me when the product is available`
  String get tellMeWhenProduct {
    return Intl.message(
      'Notify me when the product is available',
      name: 'tellMeWhenProduct',
      desc: '',
      args: [],
    );
  }

  /// `Add delivery address`
  String get addAddressDeleivery {
    return Intl.message(
      'Add delivery address',
      name: 'addAddressDeleivery',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Congratulations, discount applied successfully`
  String get discountApplied {
    return Intl.message(
      'Congratulations, discount applied successfully',
      name: 'discountApplied',
      desc: '',
      args: [],
    );
  }

  /// `Your order was placed successfully!`
  String get orderPlacedSuccess {
    return Intl.message(
      'Your order was placed successfully!',
      name: 'orderPlacedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Click here to view order details`
  String get orderPlacedSuccess2 {
    return Intl.message(
      'Click here to view order details',
      name: 'orderPlacedSuccess2',
      desc: '',
      args: [],
    );
  }

  /// `Track order`
  String get trackOrder {
    return Intl.message('Track order', name: 'trackOrder', desc: '', args: []);
  }

  /// `Order submitted`
  String get orderSubmitted {
    return Intl.message(
      'Order submitted',
      name: 'orderSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message('Confirmed', name: 'confirmed', desc: '', args: []);
  }

  /// `On delivery`
  String get onDeleivery {
    return Intl.message('On delivery', name: 'onDeleivery', desc: '', args: []);
  }

  /// `Delivered`
  String get delivered {
    return Intl.message('Delivered', name: 'delivered', desc: '', args: []);
  }

  /// `Current`
  String get current1 {
    return Intl.message('Current', name: 'current1', desc: '', args: []);
  }

  /// `Order submitted`
  String get current2 {
    return Intl.message(
      'Order submitted',
      name: 'current2',
      desc: '',
      args: [],
    );
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Returns`
  String get returns {
    return Intl.message('Returns', name: 'returns', desc: '', args: []);
  }

  /// `Canceled`
  String get canceled {
    return Intl.message('Canceled', name: 'canceled', desc: '', args: []);
  }

  /// `No orders`
  String get noOrders {
    return Intl.message('No orders', name: 'noOrders', desc: '', args: []);
  }

  /// `It seems you don't have any orders currently. You can add new orders to view them here. If you need help, contact us!`
  String get noOrdersBody {
    return Intl.message(
      'It seems you don\'t have any orders currently. You can add new orders to view them here. If you need help, contact us!',
      name: 'noOrdersBody',
      desc: '',
      args: [],
    );
  }

  /// `Order code`
  String get orderNumber {
    return Intl.message('Order code', name: 'orderNumber', desc: '', args: []);
  }

  /// `Order details`
  String get orderDetails {
    return Intl.message(
      'Order details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Rate product`
  String get rateProduct {
    return Intl.message(
      'Rate product',
      name: 'rateProduct',
      desc: '',
      args: [],
    );
  }

  /// `Do you need help?`
  String get doYouHaveHelp {
    return Intl.message(
      'Do you need help?',
      name: 'doYouHaveHelp',
      desc: '',
      args: [],
    );
  }

  /// `We are here to serve you! If you have any inquiries about orders or products, don't hesitate to contact us via:`
  String get doYouHaveHelpBody {
    return Intl.message(
      'We are here to serve you! If you have any inquiries about orders or products, don\'t hesitate to contact us via:',
      name: 'doYouHaveHelpBody',
      desc: '',
      args: [],
    );
  }

  /// `Contact us - Sales support`
  String get contactUs {
    return Intl.message(
      'Contact us - Sales support',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `We are here to serve you! If you have any inquiries about orders or products, don't hesitate to contact us via:`
  String get contactUs2 {
    return Intl.message(
      'We are here to serve you! If you have any inquiries about orders or products, don\'t hesitate to contact us via:',
      name: 'contactUs2',
      desc: '',
      args: [],
    );
  }

  /// `WhatsApp`
  String get whatsApp {
    return Intl.message('WhatsApp', name: 'whatsApp', desc: '', args: []);
  }

  /// `Phone call`
  String get call {
    return Intl.message('Phone call', name: 'call', desc: '', args: []);
  }

  /// `Live chat`
  String get chat {
    return Intl.message('Live chat', name: 'chat', desc: '', args: []);
  }

  /// `Contact us`
  String get secondry1 {
    return Intl.message('Contact us', name: 'secondry1', desc: '', args: []);
  }

  /// `You can message us on WhatsApp or follow us on Instagram to see the latest offers and products`
  String get secondry2 {
    return Intl.message(
      'You can message us on WhatsApp or follow us on Instagram to see the latest offers and products',
      name: 'secondry2',
      desc: '',
      args: [],
    );
  }

  /// `Instagram`
  String get instagram {
    return Intl.message('Instagram', name: 'instagram', desc: '', args: []);
  }

  /// `Please select the address first`
  String get locationValidation {
    return Intl.message(
      'Please select the address first',
      name: 'locationValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please select payment method first`
  String get paymentValidation {
    return Intl.message(
      'Please select payment method first',
      name: 'paymentValidation',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this address?`
  String get doYouWantToDeleteAddress {
    return Intl.message(
      'Do you want to delete this address?',
      name: 'doYouWantToDeleteAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit address`
  String get updateLocation {
    return Intl.message(
      'Edit address',
      name: 'updateLocation',
      desc: '',
      args: [],
    );
  }

  /// `Set as default`
  String get setAsDefault {
    return Intl.message(
      'Set as default',
      name: 'setAsDefault',
      desc: '',
      args: [],
    );
  }

  /// `Pay via Zain Cash`
  String get zain_cash {
    return Intl.message(
      'Pay via Zain Cash',
      name: 'zain_cash',
      desc: '',
      args: [],
    );
  }

  /// `Cancel order`
  String get cancelOrder {
    return Intl.message(
      'Cancel order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel the order?`
  String get cancelOrderBody {
    return Intl.message(
      'Are you sure you want to cancel the order?',
      name: 'cancelOrderBody',
      desc: '',
      args: [],
    );
  }

  /// `Out for delivery`
  String get outForDeleivery {
    return Intl.message(
      'Out for delivery',
      name: 'outForDeleivery',
      desc: '',
      args: [],
    );
  }

  /// `Price: Lowest to Highest`
  String get highToLowPrice {
    return Intl.message(
      'Price: Lowest to Highest',
      name: 'highToLowPrice',
      desc: '',
      args: [],
    );
  }

  /// `Price: Highest to Lowest`
  String get lowToLowPrice {
    return Intl.message(
      'Price: Highest to Lowest',
      name: 'lowToLowPrice',
      desc: '',
      args: [],
    );
  }

  /// `Write your message here`
  String get chatHint {
    return Intl.message(
      'Write your message here',
      name: 'chatHint',
      desc: '',
      args: [],
    );
  }

  /// `No conversation found`
  String get noChatFound {
    return Intl.message(
      'No conversation found',
      name: 'noChatFound',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Logout`
  String get logoutYes {
    return Intl.message('Logout', name: 'logoutYes', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get logoutBody {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutBody',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired!\nPlease login again or contact Taxito app support.`
  String get sessionExpired {
    return Intl.message(
      'Your session has expired!\nPlease login again or contact Taxito app support.',
      name: 'sessionExpired',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, this feature requires login. Please login to continue enjoying all app features.`
  String get guestLogin {
    return Intl.message(
      'Sorry, this feature requires login. Please login to continue enjoying all app features.',
      name: 'guestLogin',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest {
    return Intl.message('Guest', name: 'guest', desc: '', args: []);
  }

  /// `Write your review`
  String get enterYouRating {
    return Intl.message(
      'Write your review',
      name: 'enterYouRating',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message('Later', name: 'later', desc: '', args: []);
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Gifts`
  String get gifts {
    return Intl.message('Gifts', name: 'gifts', desc: '', args: []);
  }

  /// `Current points`
  String get currentPoints {
    return Intl.message(
      'Current points',
      name: 'currentPoints',
      desc: '',
      args: [],
    );
  }

  /// `Free shipping`
  String get freeDeleivery {
    return Intl.message(
      'Free shipping',
      name: 'freeDeleivery',
      desc: '',
      args: [],
    );
  }

  /// `Order points`
  String get orderPoints {
    return Intl.message(
      'Order points',
      name: 'orderPoints',
      desc: '',
      args: [],
    );
  }

  /// `Per`
  String get per {
    return Intl.message('Per', name: 'per', desc: '', args: []);
  }

  /// `point`
  String get point {
    return Intl.message('point', name: 'point', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Click here to redeem points`
  String get clickToReplacePoints {
    return Intl.message(
      'Click here to redeem points',
      name: 'clickToReplacePoints',
      desc: '',
      args: [],
    );
  }

  /// `In preparation`
  String get processing {
    return Intl.message(
      'In preparation',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to place the order?`
  String get confirmOrder {
    return Intl.message(
      'Are you sure you want to place the order?',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order`
  String get confirmOrderTitle {
    return Intl.message(
      'Confirm order',
      name: 'confirmOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get reload {
    return Intl.message('Reload', name: 'reload', desc: '', args: []);
  }

  /// `No Internet Connection`
  String get noNetwork {
    return Intl.message(
      'No Internet Connection',
      name: 'noNetwork',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection. Please check your connection and try again.`
  String get noNetworkBody {
    return Intl.message(
      'No internet connection. Please check your connection and try again.',
      name: 'noNetworkBody',
      desc: '',
      args: [],
    );
  }

  /// `Everything you need... in Ringo!`
  String get onBoardingTitle1 {
    return Intl.message(
      'Everything you need... in Ringo!',
      name: 'onBoardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Order your food and household essentials easily, with secure payment options to ensure a comfortable shopping experience`
  String get onBoardingBody1 {
    return Intl.message(
      'Order your food and household essentials easily, with secure payment options to ensure a comfortable shopping experience',
      name: 'onBoardingBody1',
      desc: '',
      args: [],
    );
  }

  /// `All your orders in one place!`
  String get onBoardingTitle2 {
    return Intl.message(
      'All your orders in one place!',
      name: 'onBoardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Order your food and household essentials easily, with secure payment options to ensure a comfortable shopping experience`
  String get onBoardingBody2 {
    return Intl.message(
      'Order your food and household essentials easily, with secure payment options to ensure a comfortable shopping experience',
      name: 'onBoardingBody2',
      desc: '',
      args: [],
    );
  }

  /// `(Optional)`
  String get optional {
    return Intl.message('(Optional)', name: 'optional', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Student`
  String get student {
    return Intl.message('Student', name: 'student', desc: '', args: []);
  }

  /// `Employee`
  String get employee {
    return Intl.message('Employee', name: 'employee', desc: '', args: []);
  }

  /// `Student or employee?`
  String get studentOrEmployee {
    return Intl.message(
      'Student or employee?',
      name: 'studentOrEmployee',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Verify phone number`
  String get verifyPhoneNumber {
    return Intl.message(
      'Verify phone number',
      name: 'verifyPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Select location`
  String get locationPicker {
    return Intl.message(
      'Select location',
      name: 'locationPicker',
      desc: '',
      args: [],
    );
  }

  /// `Where are you now?`
  String get whereAreUNow {
    return Intl.message(
      'Where are you now?',
      name: 'whereAreUNow',
      desc: '',
      args: [],
    );
  }

  /// `Allow Ringo to know your location to deliver to you quickly, and show you the best offers and services near you!`
  String get whereAreUNow2 {
    return Intl.message(
      'Allow Ringo to know your location to deliver to you quickly, and show you the best offers and services near you!',
      name: 'whereAreUNow2',
      desc: '',
      args: [],
    );
  }

  /// `Select another location`
  String get selectAnotherLocation {
    return Intl.message(
      'Select another location',
      name: 'selectAnotherLocation',
      desc: '',
      args: [],
    );
  }

  /// `25% off all burger meals!`
  String get banners1 {
    return Intl.message(
      '25% off all burger meals!',
      name: 'banners1',
      desc: '',
      args: [],
    );
  }

  /// `Order taxi easily and safely`
  String get banners2 {
    return Intl.message(
      'Order taxi easily and safely',
      name: 'banners2',
      desc: '',
      args: [],
    );
  }

  /// `Order now`
  String get orderNow {
    return Intl.message('Order now', name: 'orderNow', desc: '', args: []);
  }

  /// `Food order`
  String get foodRequest {
    return Intl.message('Food order', name: 'foodRequest', desc: '', args: []);
  }

  /// `What would you like to order?\n`
  String get searchHint {
    return Intl.message(
      'What would you like to order?\n',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `View by`
  String get viewBy {
    return Intl.message('View by', name: 'viewBy', desc: '', args: []);
  }

  /// `Highest rated`
  String get highestRated {
    return Intl.message(
      'Highest rated',
      name: 'highestRated',
      desc: '',
      args: [],
    );
  }

  /// `Recently added`
  String get recentlyAdded {
    return Intl.message(
      'Recently added',
      name: 'recentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Show available products first`
  String get showAvailableProductsFirst {
    return Intl.message(
      'Show available products first',
      name: 'showAvailableProductsFirst',
      desc: '',
      args: [],
    );
  }

  /// `Lowest to highest price`
  String get mostPrice {
    return Intl.message(
      'Lowest to highest price',
      name: 'mostPrice',
      desc: '',
      args: [],
    );
  }

  /// `Highest to lowest price`
  String get lowestPrice {
    return Intl.message(
      'Highest to lowest price',
      name: 'lowestPrice',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! No notifications currently`
  String get sorryNoNotifications1 {
    return Intl.message(
      'Sorry! No notifications currently',
      name: 'sorryNoNotifications1',
      desc: '',
      args: [],
    );
  }

  /// `You haven't found any notifications at this time. You can check later`
  String get sorryNoNotifications2 {
    return Intl.message(
      'You haven\'t found any notifications at this time. You can check later',
      name: 'sorryNoNotifications2',
      desc: '',
      args: [],
    );
  }

  /// `Back to home page`
  String get backHome {
    return Intl.message(
      'Back to home page',
      name: 'backHome',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message('minute', name: 'minute', desc: '', args: []);
  }

  /// `Required`
  String get isRequired {
    return Intl.message('Required', name: 'isRequired', desc: '', args: []);
  }

  /// `Do you have any notes or special requests?`
  String get doYouHaveAnyNote {
    return Intl.message(
      'Do you have any notes or special requests?',
      name: 'doYouHaveAnyNote',
      desc: '',
      args: [],
    );
  }

  /// `Write it here`
  String get writeItHere {
    return Intl.message(
      'Write it here',
      name: 'writeItHere',
      desc: '',
      args: [],
    );
  }

  /// `Write your note here...`
  String get writeNoteHere {
    return Intl.message(
      'Write your note here...',
      name: 'writeNoteHere',
      desc: '',
      args: [],
    );
  }

  /// `Save note`
  String get saveNote {
    return Intl.message('Save note', name: 'saveNote', desc: '', args: []);
  }

  /// `Go to checkout`
  String get goToCheckOut {
    return Intl.message(
      'Go to checkout',
      name: 'goToCheckOut',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  /// `Bank card`
  String get visa {
    return Intl.message('Bank card', name: 'visa', desc: '', args: []);
  }

  /// `Ringo wallet`
  String get wallet {
    return Intl.message('Ringo wallet', name: 'wallet', desc: '', args: []);
  }

  /// `Order summary`
  String get orderSummary {
    return Intl.message(
      'Order summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Product price`
  String get productPrice {
    return Intl.message(
      'Product price',
      name: 'productPrice',
      desc: '',
      args: [],
    );
  }

  /// `Complete order`
  String get doOrder {
    return Intl.message('Complete order', name: 'doOrder', desc: '', args: []);
  }

  /// `Your order has been confirmed successfully!`
  String get orderSuccess {
    return Intl.message(
      'Your order has been confirmed successfully!',
      name: 'orderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your order is being prepared now, and we will notify you when it's out for delivery.`
  String get orderSuccessHint {
    return Intl.message(
      'Your order is being prepared now, and we will notify you when it\'s out for delivery.',
      name: 'orderSuccessHint',
      desc: '',
      args: [],
    );
  }

  /// `Back to shopping`
  String get backShopping {
    return Intl.message(
      'Back to shopping',
      name: 'backShopping',
      desc: '',
      args: [],
    );
  }

  /// `Location without name`
  String get defaultLocation {
    return Intl.message(
      'Location without name',
      name: 'defaultLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please wait until your location is determined`
  String get waitLocation {
    return Intl.message(
      'Please wait until your location is determined',
      name: 'waitLocation',
      desc: '',
      args: [],
    );
  }

  /// `Order submitted`
  String get pendingTitle {
    return Intl.message(
      'Order submitted',
      name: 'pendingTitle',
      desc: '',
      args: [],
    );
  }

  /// `We have received your order successfully and will start preparing it immediately`
  String get pendingBody {
    return Intl.message(
      'We have received your order successfully and will start preparing it immediately',
      name: 'pendingBody',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Confirmed`
  String get confirmedTitle {
    return Intl.message(
      'Confirmed',
      name: 'confirmedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Order confirmed and being prepared for delivery`
  String get confirmedBody {
    return Intl.message(
      'Order confirmed and being prepared for delivery',
      name: 'confirmedBody',
      desc: '',
      args: [],
    );
  }

  /// `Out for delivery`
  String get outForDelivery1 {
    return Intl.message(
      'Out for delivery',
      name: 'outForDelivery1',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get deleiverd {
    return Intl.message('Delivered', name: 'deleiverd', desc: '', args: []);
  }

  /// `My orders`
  String get myOrders {
    return Intl.message('My orders', name: 'myOrders', desc: '', args: []);
  }

  /// `Rate seller`
  String get rateSeller {
    return Intl.message('Rate seller', name: 'rateSeller', desc: '', args: []);
  }

  /// `Rate delivery`
  String get rateDelivery {
    return Intl.message(
      'Rate delivery',
      name: 'rateDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Rate products`
  String get rateProduct1 {
    return Intl.message(
      'Rate products',
      name: 'rateProduct1',
      desc: '',
      args: [],
    );
  }

  /// `How was your experience with the seller?`
  String get rateSellerBody {
    return Intl.message(
      'How was your experience with the seller?',
      name: 'rateSellerBody',
      desc: '',
      args: [],
    );
  }

  /// `Trip history`
  String get tripHistory {
    return Intl.message(
      'Trip history',
      name: 'tripHistory',
      desc: '',
      args: [],
    );
  }

  /// `My wallet balance`
  String get walletBalance {
    return Intl.message(
      'My wallet balance',
      name: 'walletBalance',
      desc: '',
      args: [],
    );
  }

  /// `Add balance to wallet`
  String get addBalance {
    return Intl.message(
      'Add balance to wallet',
      name: 'addBalance',
      desc: '',
      args: [],
    );
  }

  /// `Transaction history`
  String get transactionHistory {
    return Intl.message(
      'Transaction history',
      name: 'transactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Enter the balance amount you want to add`
  String get addBalanceHint {
    return Intl.message(
      'Enter the balance amount you want to add',
      name: 'addBalanceHint',
      desc: '',
      args: [],
    );
  }

  /// `Wallet topped up successfully`
  String get balanceAddedSuccessfully {
    return Intl.message(
      'Wallet topped up successfully',
      name: 'balanceAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `My balance`
  String get balance {
    return Intl.message('My balance', name: 'balance', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Stores`
  String get suppliers {
    return Intl.message('Stores', name: 'suppliers', desc: '', args: []);
  }

  /// `Send complaint or inquiry`
  String get sendSuggestion {
    return Intl.message(
      'Send complaint or inquiry',
      name: 'sendSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get whoAreU {
    return Intl.message('About us', name: 'whoAreU', desc: '', args: []);
  }

  /// `Our app is your comprehensive platform for taxi services, delivery, shopping, and food orders — all in one easy and fast app.`
  String get whoAreU1 {
    return Intl.message(
      'Our app is your comprehensive platform for taxi services, delivery, shopping, and food orders — all in one easy and fast app.',
      name: 'whoAreU1',
      desc: '',
      args: [],
    );
  }

  /// `Our message`
  String get ourMessage {
    return Intl.message('Our message', name: 'ourMessage', desc: '', args: []);
  }

  /// `Our vision`
  String get ourVision {
    return Intl.message('Our vision', name: 'ourVision', desc: '', args: []);
  }

  /// `What do we offer?`
  String get whatDoWeOffer {
    return Intl.message(
      'What do we offer?',
      name: 'whatDoWeOffer',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get whyWe {
    return Intl.message('About us', name: 'whyWe', desc: '', args: []);
  }

  /// `Report an issue`
  String get reportOnIssue {
    return Intl.message(
      'Report an issue',
      name: 'reportOnIssue',
      desc: '',
      args: [],
    );
  }

  /// `Report a problem you encountered`
  String get enterYourProblem {
    return Intl.message(
      'Report a problem you encountered',
      name: 'enterYourProblem',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the problem you are facing so we can help you as soon as possible`
  String get IssueMessageValidation {
    return Intl.message(
      'Please enter the problem you are facing so we can help you as soon as possible',
      name: 'IssueMessageValidation',
      desc: '',
      args: [],
    );
  }

  /// `Search for driver`
  String get searchForDriver {
    return Intl.message(
      'Search for driver',
      name: 'searchForDriver',
      desc: '',
      args: [],
    );
  }

  /// `Car brand`
  String get carModel {
    return Intl.message('Car brand', name: 'carModel', desc: '', args: []);
  }

  /// `Passenger is waiting for you..`
  String get waitingDriver {
    return Intl.message(
      'Passenger is waiting for you..',
      name: 'waitingDriver',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelled {
    return Intl.message('Cancel', name: 'cancelled', desc: '', args: []);
  }

  /// `Reached the customer`
  String get pickedClient {
    return Intl.message(
      'Reached the customer',
      name: 'pickedClient',
      desc: '',
      args: [],
    );
  }

  /// `Delivering customer`
  String get in_progress {
    return Intl.message(
      'Delivering customer',
      name: 'in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Searching for a suitable driver for your trip, please wait`
  String get searchingForDriverTitle {
    return Intl.message(
      'Searching for a suitable driver for your trip, please wait',
      name: 'searchingForDriverTitle',
      desc: '',
      args: [],
    );
  }

  /// `The search may take a few minutes..`
  String get searchingForDriverBody {
    return Intl.message(
      'The search may take a few minutes..',
      name: 'searchingForDriverBody',
      desc: '',
      args: [],
    );
  }

  /// `Cancel trip`
  String get cancelDriver {
    return Intl.message(
      'Cancel trip',
      name: 'cancelDriver',
      desc: '',
      args: [],
    );
  }

  /// `Please note that a cancellation fee will be applied unless the trip is canceled before`
  String get searchingForDriverBody2 {
    return Intl.message(
      'Please note that a cancellation fee will be applied unless the trip is canceled before',
      name: 'searchingForDriverBody2',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get sendMessage {
    return Intl.message(
      'Send Message',
      name: 'sendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm origin point`
  String get confirmStartPoint {
    return Intl.message(
      'Confirm origin point',
      name: 'confirmStartPoint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm destination point`
  String get confirmArrivePoint {
    return Intl.message(
      'Confirm destination point',
      name: 'confirmArrivePoint',
      desc: '',
      args: [],
    );
  }

  /// `Please select the origin point first`
  String get confirmStartPointValidation {
    return Intl.message(
      'Please select the origin point first',
      name: 'confirmStartPointValidation',
      desc: '',
      args: [],
    );
  }

  /// `Please select the destination point first`
  String get confirmArrivePointValidation {
    return Intl.message(
      'Please select the destination point first',
      name: 'confirmArrivePointValidation',
      desc: '',
      args: [],
    );
  }

  /// `Where are you going?`
  String get whereAreYouGoing {
    return Intl.message(
      'Where are you going?',
      name: 'whereAreYouGoing',
      desc: '',
      args: [],
    );
  }

  /// `Search ...`
  String get search {
    return Intl.message('Search ...', name: 'search', desc: '', args: []);
  }

  /// `No previous transactions`
  String get noTransactionsFound {
    return Intl.message(
      'No previous transactions',
      name: 'noTransactionsFound',
      desc: '',
      args: [],
    );
  }

  /// `Your request is pending`
  String get yourRequestUnderReview {
    return Intl.message(
      'Your request is pending',
      name: 'yourRequestUnderReview',
      desc: '',
      args: [],
    );
  }

  /// `Request approval takes from`
  String get yourRequestUnderReview1 {
    return Intl.message(
      'Request approval takes from',
      name: 'yourRequestUnderReview1',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message('to', name: 'to', desc: '', args: []);
  }

  /// `hour`
  String get hour {
    return Intl.message('hour', name: 'hour', desc: '', args: []);
  }

  /// `Personal information`
  String get personalInfo {
    return Intl.message(
      'Personal information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstName {
    return Intl.message('First name', name: 'firstName', desc: '', args: []);
  }

  /// `Second name`
  String get secondName {
    return Intl.message('Second name', name: 'secondName', desc: '', args: []);
  }

  /// `Profile picture is required`
  String get profileImageValidation {
    return Intl.message(
      'Profile picture is required',
      name: 'profileImageValidation',
      desc: '',
      args: [],
    );
  }

  /// `Front side of ID card`
  String get frontPhoto {
    return Intl.message(
      'Front side of ID card',
      name: 'frontPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Back side of ID card`
  String get backPhoto {
    return Intl.message(
      'Back side of ID card',
      name: 'backPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Upload files in png, jpg, jpeg, heic, pdf formats`
  String get photoValidation {
    return Intl.message(
      'Upload files in png, jpg, jpeg, heic, pdf formats',
      name: 'photoValidation',
      desc: '',
      args: [],
    );
  }

  /// `Data updated successfully`
  String get userUpdatedSuccessfully {
    return Intl.message(
      'Data updated successfully',
      name: 'userUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `License data`
  String get licenseData {
    return Intl.message(
      'License data',
      name: 'licenseData',
      desc: '',
      args: [],
    );
  }

  /// `Plate numbers`
  String get plateNumbers {
    return Intl.message(
      'Plate numbers',
      name: 'plateNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Front side of driving license`
  String get frontDrivingLicence {
    return Intl.message(
      'Front side of driving license',
      name: 'frontDrivingLicence',
      desc: '',
      args: [],
    );
  }

  /// `Back side of driving license`
  String get backDrivingLicence {
    return Intl.message(
      'Back side of driving license',
      name: 'backDrivingLicence',
      desc: '',
      args: [],
    );
  }

  /// `Front side of annual registration`
  String get frontImage {
    return Intl.message(
      'Front side of annual registration',
      name: 'frontImage',
      desc: '',
      args: [],
    );
  }

  /// `Back side of annual registration`
  String get backImage {
    return Intl.message(
      'Back side of annual registration',
      name: 'backImage',
      desc: '',
      args: [],
    );
  }

  /// `Letters - numbers`
  String get numberChar {
    return Intl.message(
      'Letters - numbers',
      name: 'numberChar',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle information`
  String get vehicleInfo {
    return Intl.message(
      'Vehicle information',
      name: 'vehicleInfo',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle photo`
  String get vehicleImage {
    return Intl.message(
      'Vehicle photo',
      name: 'vehicleImage',
      desc: '',
      args: [],
    );
  }

  /// `Please upload at least 5 photos of the vehicle`
  String get vehicleImageHint {
    return Intl.message(
      'Please upload at least 5 photos of the vehicle',
      name: 'vehicleImageHint',
      desc: '',
      args: [],
    );
  }

  /// `Front side of vehicle insurance`
  String get frontInsurancePhoto {
    return Intl.message(
      'Front side of vehicle insurance',
      name: 'frontInsurancePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Back side of vehicle insurance`
  String get backInsurancePhoto {
    return Intl.message(
      'Back side of vehicle insurance',
      name: 'backInsurancePhoto',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Available`
  String get available {
    return Intl.message('Available', name: 'available', desc: '', args: []);
  }

  /// `Required documents`
  String get requiredPapers {
    return Intl.message(
      'Required documents',
      name: 'requiredPapers',
      desc: '',
      args: [],
    );
  }

  /// `Please attach the required documents below to join the Juwa Saih driver team`
  String get requiredPapersBody {
    return Intl.message(
      'Please attach the required documents below to join the Juwa Saih driver team',
      name: 'requiredPapersBody',
      desc: '',
      args: [],
    );
  }

  /// `*Please note that an OTP code will be sent to your phone to enable login`
  String get phoneBody {
    return Intl.message(
      '*Please note that an OTP code will be sent to your phone to enable login',
      name: 'phoneBody',
      desc: '',
      args: [],
    );
  }

  /// `You can request an OTP code after`
  String get youCanRequest {
    return Intl.message(
      'You can request an OTP code after',
      name: 'youCanRequest',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get second {
    return Intl.message('seconds', name: 'second', desc: '', args: []);
  }

  /// `Login to your account`
  String get loginToYourAccount {
    return Intl.message(
      'Login to your account',
      name: 'loginToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `By clicking 'I agree', you have read and agreed to`
  String get terms1 {
    return Intl.message(
      'By clicking \'I agree\', you have read and agreed to',
      name: 'terms1',
      desc: '',
      args: [],
    );
  }

  /// `and are fully aware`
  String get terms2 {
    return Intl.message(
      'and are fully aware',
      name: 'terms2',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get profile1 {
    return Intl.message('Account', name: 'profile1', desc: '', args: []);
  }

  /// `Accept Request`
  String get acceptRequest {
    return Intl.message(
      'Accept Request',
      name: 'acceptRequest',
      desc: '',
      args: [],
    );
  }

  /// `Reject Request`
  String get rejectRequest {
    return Intl.message(
      'Reject Request',
      name: 'rejectRequest',
      desc: '',
      args: [],
    );
  }

  /// `Not available`
  String get notAvailable {
    return Intl.message(
      'Not available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Trip completed`
  String get completed1 {
    return Intl.message(
      'Trip completed',
      name: 'completed1',
      desc: '',
      args: [],
    );
  }

  /// `Has paid`
  String get driverPaymentConfirmation1 {
    return Intl.message(
      'Has paid',
      name: 'driverPaymentConfirmation1',
      desc: '',
      args: [],
    );
  }

  /// `Can you confirm receipt?`
  String get driverPaymentConfirmation2 {
    return Intl.message(
      'Can you confirm receipt?',
      name: 'driverPaymentConfirmation2',
      desc: '',
      args: [],
    );
  }

  /// `Start Trip`
  String get beginTrip {
    return Intl.message('Start Trip', name: 'beginTrip', desc: '', args: []);
  }

  /// `Origin Point`
  String get originPoint {
    return Intl.message(
      'Origin Point',
      name: 'originPoint',
      desc: '',
      args: [],
    );
  }

  /// `Destination Point`
  String get destinationPoint {
    return Intl.message(
      'Destination Point',
      name: 'destinationPoint',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `Meter`
  String get meter {
    return Intl.message('Meter', name: 'meter', desc: '', args: []);
  }

  /// `Trip`
  String get trip {
    return Intl.message('Trip', name: 'trip', desc: '', args: []);
  }

  /// `Zain Cash`
  String get zainCash {
    return Intl.message('Zain Cash', name: 'zainCash', desc: '', args: []);
  }

  /// `FIB`
  String get fib {
    return Intl.message('FIB', name: 'fib', desc: '', args: []);
  }

  /// `Fast Pay`
  String get fastPay {
    return Intl.message('Fast Pay', name: 'fastPay', desc: '', args: []);
  }

  /// `Coupon`
  String get coupon {
    return Intl.message('Coupon', name: 'coupon', desc: '', args: []);
  }

  /// `Please Choose Payment Method First`
  String get paymentMethodValidation {
    return Intl.message(
      'Please Choose Payment Method First',
      name: 'paymentMethodValidation',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message('Now', name: 'now', desc: '', args: []);
  }

  /// `Choose the payment method that suits you`
  String get choosePaymentMethod {
    return Intl.message(
      'Choose the payment method that suits you',
      name: 'choosePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `The application allows you to choose from different payment methods that are suitable for you`
  String get choosePaymentMethodBody {
    return Intl.message(
      'The application allows you to choose from different payment methods that are suitable for you',
      name: 'choosePaymentMethodBody',
      desc: '',
      args: [],
    );
  }

  /// `Trip details`
  String get tripDetails {
    return Intl.message(
      'Trip details',
      name: 'tripDetails',
      desc: '',
      args: [],
    );
  }

  /// `Discount Code`
  String get discountCode {
    return Intl.message(
      'Discount Code',
      name: 'discountCode',
      desc: '',
      args: [],
    );
  }

  /// `The client has been delivered`
  String get clientDelivered {
    return Intl.message(
      'The client has been delivered',
      name: 'clientDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Rate the trip`
  String get rateTripTitle {
    return Intl.message(
      'Rate the trip',
      name: 'rateTripTitle',
      desc: '',
      args: [],
    );
  }

  /// `We hope you enjoyed your trip with us`
  String get rateTripBody {
    return Intl.message(
      'We hope you enjoyed your trip with us',
      name: 'rateTripBody',
      desc: '',
      args: [],
    );
  }

  /// `Rate the driver`
  String get rateDriver {
    return Intl.message(
      'Rate the driver',
      name: 'rateDriver',
      desc: '',
      args: [],
    );
  }

  /// `How was your experience with the driver`
  String get rateDriverBody {
    return Intl.message(
      'How was your experience with the driver',
      name: 'rateDriverBody',
      desc: '',
      args: [],
    );
  }

  /// `Send rating`
  String get sendRating {
    return Intl.message('Send rating', name: 'sendRating', desc: '', args: []);
  }

  /// `We are grateful for your feedback on the driver, your comments help us continuously improve our services.`
  String get successRating {
    return Intl.message(
      'We are grateful for your feedback on the driver, your comments help us continuously improve our services.',
      name: 'successRating',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your rating note first`
  String get ratingMessageValidation {
    return Intl.message(
      'Please enter your rating note first',
      name: 'ratingMessageValidation',
      desc: '',
      args: [],
    );
  }

  /// `No driver found`
  String get noRatingFound {
    return Intl.message(
      'No driver found',
      name: 'noRatingFound',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations, you have reached an arrive point. Please pay`
  String get payToDriver {
    return Intl.message(
      'Congratulations, you have reached an arrive point. Please pay',
      name: 'payToDriver',
      desc: '',
      args: [],
    );
  }

  /// `To the driver`
  String get toTheDriver {
    return Intl.message(
      'To the driver',
      name: 'toTheDriver',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for the driver to confirm the payment request`
  String get waitingDriverToAccept {
    return Intl.message(
      'Waiting for the driver to confirm the payment request',
      name: 'waitingDriverToAccept',
      desc: '',
      args: [],
    );
  }

  /// `No trips found`
  String get noTrips {
    return Intl.message('No trips found', name: 'noTrips', desc: '', args: []);
  }

  /// `Please wait while the passenger makes payment`
  String get waitUserToPay {
    return Intl.message(
      'Please wait while the passenger makes payment',
      name: 'waitUserToPay',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copyGift {
    return Intl.message('Copy', name: 'copyGift', desc: '', args: []);
  }

  /// `Gift Code Copied Success`
  String get copySuccess {
    return Intl.message(
      'Gift Code Copied Success',
      name: 'copySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Erbil International Airport`
  String get airPortInfo {
    return Intl.message(
      'Erbil International Airport',
      name: 'airPortInfo',
      desc: '',
      args: [],
    );
  }

  /// `Track On Google Map`
  String get trackOnGoogleMap {
    return Intl.message(
      'Track On Google Map',
      name: 'trackOnGoogleMap',
      desc: '',
      args: [],
    );
  }

  /// `Who Are you`
  String get whoAreWe {
    return Intl.message('Who Are you', name: 'whoAreWe', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `You have it in your wallet`
  String get youHave {
    return Intl.message(
      'You have it in your wallet',
      name: 'youHave',
      desc: '',
      args: [],
    );
  }

  /// `Without a destination`
  String get withoutADestination {
    return Intl.message(
      'Without a destination',
      name: 'withoutADestination',
      desc: '',
      args: [],
    );
  }

  /// `Taxi driver`
  String get taxiDriver {
    return Intl.message('Taxi driver', name: 'taxiDriver', desc: '', args: []);
  }

  /// `Delivery driver`
  String get delivery {
    return Intl.message(
      'Delivery driver',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `At a distance of`
  String get distance1 {
    return Intl.message(
      'At a distance of',
      name: 'distance1',
      desc: '',
      args: [],
    );
  }

  /// `km`
  String get km {
    return Intl.message('km', name: 'km', desc: '', args: []);
  }

  /// `Delivery requests`
  String get deleiveryRequests {
    return Intl.message(
      'Delivery requests',
      name: 'deleiveryRequests',
      desc: '',
      args: [],
    );
  }

  /// `from`
  String get from {
    return Intl.message('from', name: 'from', desc: '', args: []);
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Trip distance`
  String get tripDistance {
    return Intl.message(
      'Trip distance',
      name: 'tripDistance',
      desc: '',
      args: [],
    );
  }

  /// `If you don't accept the request within `
  String get rejection1 {
    return Intl.message(
      'If you don\'t accept the request within ',
      name: 'rejection1',
      desc: '',
      args: [],
    );
  }

  /// `it will be transferred to another driver and automatically cancelled from your account.`
  String get rejection2 {
    return Intl.message(
      'it will be transferred to another driver and automatically cancelled from your account.',
      name: 'rejection2',
      desc: '',
      args: [],
    );
  }

  /// `Start trip`
  String get startTrip {
    return Intl.message('Start trip', name: 'startTrip', desc: '', args: []);
  }

  /// `Reached destination`
  String get endTrip {
    return Intl.message(
      'Reached destination',
      name: 'endTrip',
      desc: '',
      args: [],
    );
  }

  /// `Your status`
  String get yourStatus {
    return Intl.message('Your status', name: 'yourStatus', desc: '', args: []);
  }

  /// `Statistics`
  String get statics {
    return Intl.message('Statistics', name: 'statics', desc: '', args: []);
  }

  /// `Total orders`
  String get totalOrders {
    return Intl.message(
      'Total orders',
      name: 'totalOrders',
      desc: '',
      args: [],
    );
  }

  /// `Profits`
  String get profits {
    return Intl.message('Profits', name: 'profits', desc: '', args: []);
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `New`
  String get newWord {
    return Intl.message('New', name: 'newWord', desc: '', args: []);
  }

  /// `In preparation`
  String get inPreparation {
    return Intl.message(
      'In preparation',
      name: 'inPreparation',
      desc: '',
      args: [],
    );
  }

  /// `With the delegate`
  String get withTheDelegate {
    return Intl.message(
      'With the delegate',
      name: 'withTheDelegate',
      desc: '',
      args: [],
    );
  }

  /// `On delivery`
  String get onDeliver {
    return Intl.message('On delivery', name: 'onDeliver', desc: '', args: []);
  }

  /// `Contact user`
  String get contactUser {
    return Intl.message(
      'Contact user',
      name: 'contactUser',
      desc: '',
      args: [],
    );
  }

  /// `Delivery address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `If you don't accept the request within`
  String get ifNotAcceptedWithin {
    return Intl.message(
      'If you don\'t accept the request within',
      name: 'ifNotAcceptedWithin',
      desc: '',
      args: [],
    );
  }

  /// `it will be transferred to another driver and automatically cancelled from your account.`
  String get willBeTransferred {
    return Intl.message(
      'it will be transferred to another driver and automatically cancelled from your account.',
      name: 'willBeTransferred',
      desc: '',
      args: [],
    );
  }

  /// `Order received from supplier`
  String get receiveFromSupplier {
    return Intl.message(
      'Order received from supplier',
      name: 'receiveFromSupplier',
      desc: '',
      args: [],
    );
  }

  /// `Order delivered to customer`
  String get deliveryToAddress {
    return Intl.message(
      'Order delivered to customer',
      name: 'deliveryToAddress',
      desc: '',
      args: [],
    );
  }

  /// `Start delivery`
  String get startDelivery {
    return Intl.message(
      'Start delivery',
      name: 'startDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Order prepared`
  String get orderDonePrepare {
    return Intl.message(
      'Order prepared',
      name: 'orderDonePrepare',
      desc: '',
      args: [],
    );
  }

  /// `Trip duration`
  String get tripDuration {
    return Intl.message(
      'Trip duration',
      name: 'tripDuration',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message('Distance', name: 'distance', desc: '', args: []);
  }

  /// `Trip value`
  String get totalPrice1 {
    return Intl.message('Trip value', name: 'totalPrice1', desc: '', args: []);
  }

  /// `Cancel trip`
  String get cancelTripConfirm {
    return Intl.message(
      'Cancel trip',
      name: 'cancelTripConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this trip`
  String get cancelTripConfirmBody {
    return Intl.message(
      'Are you sure you want to cancel this trip',
      name: 'cancelTripConfirmBody',
      desc: '',
      args: [],
    );
  }

  /// `Contact technical support for not receiving the amount from the user`
  String get driverRejectPayment {
    return Intl.message(
      'Contact technical support for not receiving the amount from the user',
      name: 'driverRejectPayment',
      desc: '',
      args: [],
    );
  }

  /// `Having a problem?`
  String get haveProblem {
    return Intl.message(
      'Having a problem?',
      name: 'haveProblem',
      desc: '',
      args: [],
    );
  }

  /// `Order received`
  String get deliveryReceivedOrder {
    return Intl.message(
      'Order received',
      name: 'deliveryReceivedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Show order contents`
  String get showOrderDetails {
    return Intl.message(
      'Show order contents',
      name: 'showOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Hide order contents`
  String get hideOrderDetails {
    return Intl.message(
      'Hide order contents',
      name: 'hideOrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Supplier details`
  String get supplierDetails {
    return Intl.message(
      'Supplier details',
      name: 'supplierDetails',
      desc: '',
      args: [],
    );
  }

  /// `Customer details`
  String get userDetails {
    return Intl.message(
      'Customer details',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order is ready`
  String get orderIsReady {
    return Intl.message(
      'Order is ready',
      name: 'orderIsReady',
      desc: '',
      args: [],
    );
  }

  /// `Update Available`
  String get updateTitle {
    return Intl.message(
      'Update Available',
      name: 'updateTitle',
      desc: '',
      args: [],
    );
  }

  /// `A new version of the app has been released with important improvements and fixes.`
  String get updateBody {
    return Intl.message(
      'A new version of the app has been released with important improvements and fixes.',
      name: 'updateBody',
      desc: '',
      args: [],
    );
  }

  /// `Faster performance and UI enhancements.`
  String get updateBody1 {
    return Intl.message(
      'Faster performance and UI enhancements.',
      name: 'updateBody1',
      desc: '',
      args: [],
    );
  }

  /// `Bug fixes.`
  String get updateBody2 {
    return Intl.message('Bug fixes.', name: 'updateBody2', desc: '', args: []);
  }

  /// `Update Now`
  String get updateBody3 {
    return Intl.message('Update Now', name: 'updateBody3', desc: '', args: []);
  }

  /// `Show Less`
  String get showLess {
    return Intl.message('Show Less', name: 'showLess', desc: '', args: []);
  }

  /// `About the App`
  String get aboutApp {
    return Intl.message('About the App', name: 'aboutApp', desc: '', args: []);
  }

  /// `Develop`
  String get develop {
    return Intl.message('Develop', name: 'develop', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs3 {
    return Intl.message('Contact Us', name: 'contactUs3', desc: '', args: []);
  }

  /// `Made with love`
  String get copyWrite1 {
    return Intl.message(
      'Made with love',
      name: 'copyWrite1',
      desc: '',
      args: [],
    );
  }

  /// `by Jacksi Software Company`
  String get copyWrite2 {
    return Intl.message(
      'by Jacksi Software Company',
      name: 'copyWrite2',
      desc: '',
      args: [],
    );
  }

  /// `The order is being prepared and will be ready for delivery soon`
  String get inPrepareBody {
    return Intl.message(
      'The order is being prepared and will be ready for delivery soon',
      name: 'inPrepareBody',
      desc: '',
      args: [],
    );
  }

  /// `The order is ready and waiting for delivery`
  String get donePrepareBody {
    return Intl.message(
      'The order is ready and waiting for delivery',
      name: 'donePrepareBody',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message('User', name: 'user', desc: '', args: []);
  }

  /// `Supplier`
  String get supplier {
    return Intl.message('Supplier', name: 'supplier', desc: '', args: []);
  }

  /// `Enter the code you received on your phone number:`
  String get verificationCode1 {
    return Intl.message(
      'Enter the code you received on your phone number:',
      name: 'verificationCode1',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get productPrice1 {
    return Intl.message(
      'Product Price',
      name: 'productPrice1',
      desc: '',
      args: [],
    );
  }

  /// `Old Product Price`
  String get oldProductPrice {
    return Intl.message(
      'Old Product Price',
      name: 'oldProductPrice',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has arrived!`
  String get otpTitle {
    return Intl.message(
      'Verification code has arrived!',
      name: 'otpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Name`
  String get commercialName {
    return Intl.message(
      'Commercial Name',
      name: 'commercialName',
      desc: '',
      args: [],
    );
  }

  /// `Place Name`
  String get placeName {
    return Intl.message('Place Name', name: 'placeName', desc: '', args: []);
  }

  /// `Activity Type`
  String get activityType {
    return Intl.message(
      'Activity Type',
      name: 'activityType',
      desc: '',
      args: [],
    );
  }

  /// `Food Preparation Time`
  String get foodPrepare {
    return Intl.message(
      'Food Preparation Time',
      name: 'foodPrepare',
      desc: '',
      args: [],
    );
  }

  /// `30 minutes`
  String get foodPrepareHint {
    return Intl.message(
      '30 minutes',
      name: 'foodPrepareHint',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Time`
  String get foodDelivery {
    return Intl.message(
      'Delivery Time',
      name: 'foodDelivery',
      desc: '',
      args: [],
    );
  }

  /// `30 minutes`
  String get foodDeliveryHint {
    return Intl.message(
      '30 minutes',
      name: 'foodDeliveryHint',
      desc: '',
      args: [],
    );
  }

  /// `Commercial Registration Photo`
  String get commericalImage {
    return Intl.message(
      'Commercial Registration Photo',
      name: 'commericalImage',
      desc: '',
      args: [],
    );
  }

  /// `Add Location on Map`
  String get addLocationOnMap {
    return Intl.message(
      'Add Location on Map',
      name: 'addLocationOnMap',
      desc: '',
      args: [],
    );
  }

  /// `Geographical Location`
  String get geographicalLocation {
    return Intl.message(
      'Geographical Location',
      name: 'geographicalLocation',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address Manually`
  String get enterAddressManually {
    return Intl.message(
      'Enter Address Manually',
      name: 'enterAddressManually',
      desc: '',
      args: [],
    );
  }

  /// `Additions`
  String get addiontion {
    return Intl.message('Additions', name: 'addiontion', desc: '', args: []);
  }

  /// `Add New Category`
  String get addNewCategory {
    return Intl.message(
      'Add New Category',
      name: 'addNewCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category name in Arabic`
  String get arabicCategoryName {
    return Intl.message(
      'Category name in Arabic',
      name: 'arabicCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Category name in English`
  String get englishCategoryName {
    return Intl.message(
      'Category name in English',
      name: 'englishCategoryName',
      desc: '',
      args: [],
    );
  }

  /// `Attributes`
  String get attributes {
    return Intl.message('Attributes', name: 'attributes', desc: '', args: []);
  }

  /// `Add Attribute`
  String get addAttribute {
    return Intl.message(
      'Add Attribute',
      name: 'addAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Attribute Name`
  String get attributeName {
    return Intl.message(
      'Attribute Name',
      name: 'attributeName',
      desc: '',
      args: [],
    );
  }

  /// `Add New Attribute`
  String get addNewAttribute {
    return Intl.message(
      'Add New Attribute',
      name: 'addNewAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Attribute name in Arabic`
  String get arabicAttributeName {
    return Intl.message(
      'Attribute name in Arabic',
      name: 'arabicAttributeName',
      desc: '',
      args: [],
    );
  }

  /// `Attribute name in English`
  String get englishAttributeName {
    return Intl.message(
      'Attribute name in English',
      name: 'englishAttributeName',
      desc: '',
      args: [],
    );
  }

  /// `Is it a color?`
  String get isColor {
    return Intl.message('Is it a color?', name: 'isColor', desc: '', args: []);
  }

  /// `Is it multiple choice?`
  String get isMultiple {
    return Intl.message(
      'Is it multiple choice?',
      name: 'isMultiple',
      desc: '',
      args: [],
    );
  }

  /// `No (single choice)`
  String get singleChoice {
    return Intl.message(
      'No (single choice)',
      name: 'singleChoice',
      desc: '',
      args: [],
    );
  }

  /// `Save Attribute`
  String get saveAttribute {
    return Intl.message(
      'Save Attribute',
      name: 'saveAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Edit Attribute`
  String get editAttribute {
    return Intl.message(
      'Edit Attribute',
      name: 'editAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Delete Attribute`
  String get deleteAttribute {
    return Intl.message(
      'Delete Attribute',
      name: 'deleteAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this attribute?`
  String get deleteAttributeConfirm {
    return Intl.message(
      'Are you sure you want to delete this attribute?',
      name: 'deleteAttributeConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message('Add Product', name: 'addProduct', desc: '', args: []);
  }

  /// `All Products`
  String get allProducts {
    return Intl.message(
      'All Products',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Add Variant Values`
  String get subAttribute {
    return Intl.message(
      'Add Variant Values',
      name: 'subAttribute',
      desc: '',
      args: [],
    );
  }

  /// `Does it contain images?`
  String get doesItContainImages {
    return Intl.message(
      'Does it contain images?',
      name: 'doesItContainImages',
      desc: '',
      args: [],
    );
  }

  /// `Add new values for`
  String get addNewValuesFor {
    return Intl.message(
      'Add new values for',
      name: 'addNewValuesFor',
      desc: '',
      args: [],
    );
  }

  /// `Write the value here in Arabic`
  String get writeValueHereAr {
    return Intl.message(
      'Write the value here in Arabic',
      name: 'writeValueHereAr',
      desc: '',
      args: [],
    );
  }

  /// `Write the value here in English`
  String get writeValueHereEn {
    return Intl.message(
      'Write the value here in English',
      name: 'writeValueHereEn',
      desc: '',
      args: [],
    );
  }

  /// `Add Value`
  String get addValue {
    return Intl.message('Add Value', name: 'addValue', desc: '', args: []);
  }

  /// `Add New Color`
  String get addNewColor {
    return Intl.message(
      'Add New Color',
      name: 'addNewColor',
      desc: '',
      args: [],
    );
  }

  /// `Added values:`
  String get addedValues {
    return Intl.message(
      'Added values:',
      name: 'addedValues',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image Source`
  String get chooseImageSource {
    return Intl.message(
      'Choose Image Source',
      name: 'chooseImageSource',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Product Images`
  String get productImage {
    return Intl.message(
      'Product Images',
      name: 'productImage',
      desc: '',
      args: [],
    );
  }

  /// `Upload clear product images (PNG, JPG, Max 5MB)`
  String get productImage1 {
    return Intl.message(
      'Upload clear product images (PNG, JPG, Max 5MB)',
      name: 'productImage1',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productName {
    return Intl.message(
      'Product Name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `Margherita Pizza`
  String get productNameHint {
    return Intl.message(
      'Margherita Pizza',
      name: 'productNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Product Description`
  String get productDescription {
    return Intl.message(
      'Product Description',
      name: 'productDescription',
      desc: '',
      args: [],
    );
  }

  /// `Traditional Italian pizza with fresh ingredients`
  String get productDescriptionHint {
    return Intl.message(
      'Traditional Italian pizza with fresh ingredients',
      name: 'productDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category1 {
    return Intl.message('Category', name: 'category1', desc: '', args: []);
  }

  /// `Show Ratings`
  String get showRating {
    return Intl.message('Show Ratings', name: 'showRating', desc: '', args: []);
  }

  /// `Product Available?`
  String get productAva {
    return Intl.message(
      'Product Available?',
      name: 'productAva',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get deleteProduct {
    return Intl.message(
      'Delete Product',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `Is it available?`
  String get isAvailable {
    return Intl.message(
      'Is it available?',
      name: 'isAvailable',
      desc: '',
      args: [],
    );
  }

  /// `New Orders`
  String get newOrders {
    return Intl.message('New Orders', name: 'newOrders', desc: '', args: []);
  }

  /// `Verify`
  String get verifyCode {
    return Intl.message('Verify', name: 'verifyCode', desc: '', args: []);
  }

  /// `No categories available`
  String get noCategoriesFound {
    return Intl.message(
      'No categories available',
      name: 'noCategoriesFound',
      desc: '',
      args: [],
    );
  }

  /// `No products available`
  String get noProductFound {
    return Intl.message(
      'No products available',
      name: 'noProductFound',
      desc: '',
      args: [],
    );
  }

  /// `No additions available`
  String get noAttributesFound {
    return Intl.message(
      'No additions available',
      name: 'noAttributesFound',
      desc: '',
      args: [],
    );
  }

  /// `Location permission is required to use this feature. Please allow location access to continue.`
  String get locationPermissionDenied {
    return Intl.message(
      'Location permission is required to use this feature. Please allow location access to continue.',
      name: 'locationPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Location permission is permanently denied. Please enable it manually from app settings.`
  String get locationPermissionDeniedForever {
    return Intl.message(
      'Location permission is permanently denied. Please enable it manually from app settings.',
      name: 'locationPermissionDeniedForever',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get openSettings {
    return Intl.message(
      'Open Settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
