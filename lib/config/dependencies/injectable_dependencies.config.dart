// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_analytics/firebase_analytics.dart' as _i398;
import 'package:firebase_messaging/firebase_messaging.dart' as _i892;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../core/bloc/global_cubit/global_cubit.dart' as _i913;
import '../../core/bloc/socket/socket_cubit.dart' as _i771;
import '../../core/services/location/polyline_helper.dart' as _i791;
import '../../core/services/network/app_interceptors.dart' as _i181;
import '../../core/services/network/dio_consumer.dart' as _i82;
import '../../core/services/network/error/api_error_handler.dart' as _i665;
import '../../core/services/network/internet_checker/netwok_info.dart'
    as _i1035;
import '../../core/services/socket/socket.dart' as _i985;
import '../../features/captain/app/controller/pick_image/register_pick_image_cubit.dart'
    as _i988;
import '../../features/captain/app/data/datasources/app_remote_data_source.dart'
    as _i676;
import '../../features/captain/app/data/repositories/app_repository.dart'
    as _i657;
import '../../features/captain/app/domain/repositories/app_repository.dart'
    as _i81;
import '../../features/captain/app/domain/use_case/delete_image_use_case.dart'
    as _i440;
import '../../features/captain/app/domain/use_case/generate_deep_link_use_case.dart'
    as _i439;
import '../../features/captain/app/domain/use_case/upload_image_use_case.dart'
    as _i656;
import '../../features/captain/auth/data/datasources/auth_remote_data_source.dart'
    as _i56;
import '../../features/captain/auth/data/repositories/auth_repo_impl.dart'
    as _i478;
import '../../features/captain/auth/domain/repositories/auth_repository.dart'
    as _i475;
import '../../features/captain/auth/domain/usecases/delete_account_use_case.dart'
    as _i106;
import '../../features/captain/auth/domain/usecases/get_user_data_use_case.dart'
    as _i753;
import '../../features/captain/auth/domain/usecases/log_out_use_case.dart'
    as _i1020;
import '../../features/captain/auth/domain/usecases/login_user_use_case.dart'
    as _i200;
import '../../features/captain/auth/domain/usecases/register_user_use_case.dart'
    as _i1029;
import '../../features/captain/auth/domain/usecases/resend_otp_use_case.dart'
    as _i741;
import '../../features/captain/auth/domain/usecases/update_fcm_use_case.dart'
    as _i131;
import '../../features/captain/auth/domain/usecases/verify_otp_use_case.dart'
    as _i813;
import '../../features/captain/auth/presentation/cubit/complete_register/complete_register_bloc.dart'
    as _i384;
import '../../features/captain/auth/presentation/cubit/delete_account/delete_cubit.dart'
    as _i505;
import '../../features/captain/auth/presentation/cubit/login_cubit/login_cubit.dart'
    as _i622;
import '../../features/captain/auth/presentation/cubit/logout/logout_cubit.dart'
    as _i1008;
import '../../features/captain/auth/presentation/cubit/otp/otp_bloc.dart'
    as _i27;
import '../../features/captain/chat/data/datasources/chats_remote_data_source.dart'
    as _i581;
import '../../features/captain/chat/data/repositories/chats_repository_impl.dart'
    as _i1011;
import '../../features/captain/chat/domain/repositories/chats_repoitory.dart'
    as _i689;
import '../../features/captain/chat/domain/usecases/get_chat_message_use_case.dart'
    as _i417;
import '../../features/captain/chat/domain/usecases/send_chat_use_case.dart'
    as _i1041;
import '../../features/captain/chat/presentation/bloc/message/message_bloc.dart'
    as _i427;
import '../../features/captain/delivery_main/data/datasources/main_remote_data_source.dart'
    as _i843;
import '../../features/captain/delivery_main/data/repositories/main_repository_impl.dart'
    as _i63;
import '../../features/captain/delivery_main/domain/repositories/main_repository.dart'
    as _i381;
import '../../features/captain/delivery_main/domain/usecases/toggle_availability_use_case.dart'
    as _i880;
import '../../features/captain/delivery_main/presentation/cubit/availitiablity/availitiablity_cubit.dart'
    as _i44;
import '../../features/captain/delivery_main/presentation/cubit/delivery_main/delivery_main_cubit.dart'
    as _i892;
import '../../features/captain/delivery_order/data/datasources/delivery_remote_data_source.dart'
    as _i380;
import '../../features/captain/delivery_order/data/repositories/delivery_orders_repository.dart'
    as _i990;
import '../../features/captain/delivery_order/domain/repositories/delivery_orders_repository.dart'
    as _i765;
import '../../features/captain/delivery_order/domain/usecases/accept_delivery_order_use_case.dart'
    as _i378;
import '../../features/captain/delivery_order/domain/usecases/get_all_delivery_orders_use_case.dart'
    as _i96;
import '../../features/captain/delivery_order/domain/usecases/get_order_details_use_case.dart'
    as _i181;
import '../../features/captain/delivery_order/domain/usecases/get_statics_use_case.dart'
    as _i634;
import '../../features/captain/delivery_order/domain/usecases/reject_delivery_order_use_case.dart'
    as _i651;
import '../../features/captain/delivery_order/domain/usecases/update_delivery_order_use_case.dart'
    as _i90;
import '../../features/captain/delivery_order/presentation/cubit/delivery_actions/delivery_actions_cubit.dart'
    as _i170;
import '../../features/captain/delivery_order/presentation/cubit/delivery_order_cubit.dart'
    as _i163;
import '../../features/captain/delivery_order/presentation/cubit/statics/statics_cubit.dart'
    as _i312;
import '../../features/captain/delivery_order/presentation/cubit/track/track_order_cubit.dart'
    as _i604;
import '../../features/captain/driver_main/data/datasources/main_remote_data_source.dart'
    as _i967;
import '../../features/captain/driver_main/data/repositories/main_repository_impl.dart'
    as _i547;
import '../../features/captain/driver_main/domain/repositories/main_repository.dart'
    as _i752;
import '../../features/captain/driver_main/domain/usecases/toggle_availability_use_case.dart'
    as _i315;
import '../../features/captain/driver_main/presentation/cubit/availitiablity/availitiablity_cubit.dart'
    as _i639;
import '../../features/captain/driver_main/presentation/cubit/driver_home/driver_home_cubit.dart'
    as _i940;
import '../../features/captain/driver_main/presentation/cubit/driver_main/driver_main_cubit.dart'
    as _i212;
import '../../features/captain/driver_main/presentation/cubit/driver_trip_actions/driver_trip_actions_cubit.dart'
    as _i234;
import '../../features/captain/driver_trip/data/datasources/driver_trip_remote_data_source.dart'
    as _i731;
import '../../features/captain/driver_trip/data/repositories/driver_repository_repostiry.dart'
    as _i649;
import '../../features/captain/driver_trip/domain/repositories/driver_repository.dart'
    as _i700;
import '../../features/captain/driver_trip/domain/usecases/accept_driver_payment_request_use_case.dart'
    as _i353;
import '../../features/captain/driver_trip/domain/usecases/accept_trip_use_case.dart'
    as _i399;
import '../../features/captain/driver_trip/domain/usecases/cancel_trip_use_case.dart'
    as _i567;
import '../../features/captain/driver_trip/domain/usecases/end_trip_use_case.dart'
    as _i1065;
import '../../features/captain/driver_trip/domain/usecases/get_all_trips_history_use_case.dart'
    as _i707;
import '../../features/captain/driver_trip/domain/usecases/get_trip_by_id_use_case.dart'
    as _i425;
import '../../features/captain/driver_trip/domain/usecases/pending_trips_use_case.dart'
    as _i945;
import '../../features/captain/driver_trip/domain/usecases/reject_trip_use_case.dart'
    as _i612;
import '../../features/captain/driver_trip/domain/usecases/update_trip_status_use_case.dart'
    as _i372;
import '../../features/captain/driver_trip/presentation/bloc/accepted_driver_trip/accepted_driver_cubit.dart'
    as _i194;
import '../../features/captain/driver_trip/presentation/bloc/driver_history/trip_history_details_cubit.dart'
    as _i277;
import '../../features/captain/driver_trip/presentation/bloc/payment_driver_confirmation/payment_confirmation_cubit.dart'
    as _i785;
import '../../features/captain/driver_trip/presentation/bloc/trip/trip_cubit.dart'
    as _i931;
import '../../features/captain/driver_trip/presentation/bloc/trip_history/trip_history_cubit.dart'
    as _i438;
import '../../features/captain/location/data/datasources/location_local_data_source.dart'
    as _i564;
import '../../features/captain/location/data/datasources/location_remote_data_source.dart'
    as _i449;
import '../../features/captain/location/data/repositories/location_repository_impl.dart'
    as _i732;
import '../../features/captain/location/domain/repositories/location_repository.dart'
    as _i995;
import '../../features/captain/location/domain/usecases/get_details_by_latlng_use_case.dart'
    as _i375;
import '../../features/captain/location/domain/usecases/get_governorates_use_case.dart'
    as _i182;
import '../../features/captain/location/domain/usecases/get_place_details_by_place_id_use_case.dart'
    as _i547;
import '../../features/captain/location/domain/usecases/update_driver_location_use_case.dart'
    as _i979;
import '../../features/captain/location/presentation/cubit/driver_location/driver_location_cubit.dart'
    as _i184;
import '../../features/captain/location/presentation/cubit/governorate/governorate_bloc.dart'
    as _i8;
import '../../features/captain/location/presentation/cubit/location_cubit.dart'
    as _i581;
import '../../features/captain/notifications/data/datasources/notification_remote_data_source.dart'
    as _i904;
import '../../features/captain/notifications/data/repositories/notification_repository_impl.dart'
    as _i527;
import '../../features/captain/notifications/domain/repositories/notification_repository.dart'
    as _i779;
import '../../features/captain/notifications/domain/usecases/get_notification_count_use_case.dart'
    as _i150;
import '../../features/captain/notifications/domain/usecases/get_notification_list_use_case.dart'
    as _i907;
import '../../features/captain/notifications/domain/usecases/mark_all_as_read_use_case.dart'
    as _i107;
import '../../features/captain/notifications/presentation/cubit/notifications_cubit.dart'
    as _i761;
import '../../features/captain/settings/data/datasources/settings_remote_data_source.dart'
    as _i577;
import '../../features/captain/settings/data/repositories/settings_repo_impl.dart'
    as _i859;
import '../../features/captain/settings/domain/repositories/settings_repository.dart'
    as _i30;
import '../../features/captain/settings/domain/usecases/change_lang_code_use_case.dart'
    as _i663;
import '../../features/captain/settings/domain/usecases/get_app_settings_use_case.dart'
    as _i1067;
import '../../features/captain/settings/domain/usecases/get_deletion_reasons_use_case.dart'
    as _i224;
import '../../features/captain/settings/domain/usecases/get_faq_use_case.dart'
    as _i545;
import '../../features/captain/settings/domain/usecases/get_page_use_case.dart'
    as _i297;
import '../../features/captain/settings/presentation/bloc/faqs/faqs_question_cubit.dart'
    as _i398;
import '../../features/captain/settings/presentation/bloc/pages/pages_bloc.dart'
    as _i882;
import '../../features/captain/settings/presentation/bloc/settings_bloc.dart'
    as _i990;
import '../../features/captain/user/presentation/bloc/profile/profile_bloc.dart'
    as _i119;
import '../../features/captain/user/presentation/bloc/user_bloc.dart' as _i544;
import '../../features/common/start/data/datasources/init_remote_data_source.dart'
    as _i1043;
import '../../features/common/start/data/repositories/init_repo_impl.dart'
    as _i740;
import '../../features/common/start/domain/repositories/init_repostory.dart'
    as _i983;
import '../../features/common/start/domain/usecases/get_intro_use_case.dart'
    as _i1048;
import '../../features/common/start/domain/usecases/init_app_use_case.dart'
    as _i598;
import '../../features/common/start/presentation/cubit/boarding/on_boarding_cubit.dart'
    as _i430;
import '../../features/common/start/presentation/cubit/start/start_cubit.dart'
    as _i129;
import '../../features/user/auth/data/datasources/auth_remote_data_source.dart'
    as _i511;
import '../../features/user/auth/data/repositories/auth_repo_impl.dart'
    as _i384;
import '../../features/user/auth/domain/repositories/auth_repository.dart'
    as _i7;
import '../../features/user/auth/domain/usecases/delete_account_use_case.dart'
    as _i728;
import '../../features/user/auth/domain/usecases/get_user_data_use_case.dart'
    as _i477;
import '../../features/user/auth/domain/usecases/log_out_use_case.dart'
    as _i543;
import '../../features/user/auth/domain/usecases/login_user_use_case.dart'
    as _i665;
import '../../features/user/auth/domain/usecases/update_user_data_use_case.dart'
    as _i145;
import '../../features/user/auth/domain/usecases/verify_otp_use_case.dart'
    as _i333;
import '../../features/user/auth/presentation/cubit/login_cubit/login_cubit.dart'
    as _i661;
import '../../features/user/auth/presentation/cubit/logout/logout_cubit.dart'
    as _i460;
import '../../features/user/auth/presentation/cubit/otp/otp_bloc.dart' as _i1;
import '../../features/user/auth/presentation/cubit/update/update_bloc.dart'
    as _i787;
import '../../features/user/chat/data/datasources/chats_remote_data_source.dart'
    as _i31;
import '../../features/user/chat/data/repositories/chats_repository_impl.dart'
    as _i618;
import '../../features/user/chat/domain/repositories/chats_repoitory.dart'
    as _i623;
import '../../features/user/chat/domain/usecases/get_chat_message_use_case.dart'
    as _i515;
import '../../features/user/chat/domain/usecases/send_chat_use_case.dart'
    as _i1027;
import '../../features/user/chat/presentation/bloc/message/message_bloc.dart'
    as _i347;
import '../../features/user/location/data/datasources/location_remote_data_source.dart'
    as _i708;
import '../../features/user/location/data/repositories/location_repository_impl.dart'
    as _i121;
import '../../features/user/location/domain/repositories/location_repository.dart'
    as _i124;
import '../../features/user/location/domain/usecases/add_new_address_use_case.dart'
    as _i354;
import '../../features/user/location/domain/usecases/delete_address_use_case.dart'
    as _i9;
import '../../features/user/location/domain/usecases/get_address_use_case.dart'
    as _i60;
import '../../features/user/location/domain/usecases/get_details_by_latlng_use_case.dart'
    as _i481;
import '../../features/user/location/domain/usecases/get_google_suggestion_use_case.dart'
    as _i763;
import '../../features/user/location/domain/usecases/get_place_details_by_place_id_use_case.dart'
    as _i50;
import '../../features/user/location/domain/usecases/get_regions_use_case.dart'
    as _i710;
import '../../features/user/location/domain/usecases/make_address_default_use_case.dart'
    as _i1036;
import '../../features/user/location/presentation/cubit/add_new_address/add_new_address_cubit.dart'
    as _i273;
import '../../features/user/location/presentation/cubit/globale_location/global_location_cubit.dart'
    as _i858;
import '../../features/user/location/presentation/cubit/location_cubit.dart'
    as _i511;
import '../../features/user/location/presentation/cubit/location_picker/location_picker_cubit.dart'
    as _i645;
import '../../features/user/location/presentation/cubit/my_address/my_address_cubit.dart'
    as _i1035;
import '../../features/user/main/data/datasources/main_remote_data_source.dart'
    as _i14;
import '../../features/user/main/data/repositories/main_repository_impl.dart'
    as _i450;
import '../../features/user/main/domain/repositories/main_repository.dart'
    as _i523;
import '../../features/user/main/domain/usecases/get_banners_use_case.dart'
    as _i609;
import '../../features/user/main/domain/usecases/get_brand_use_case.dart'
    as _i31;
import '../../features/user/main/domain/usecases/get_main_category_use_case.dart'
    as _i45;
import '../../features/user/main/domain/usecases/update_device_token.dart'
    as _i2;
import '../../features/user/main/presentation/cubit/banner/banners_cubit.dart'
    as _i347;
import '../../features/user/main/presentation/cubit/main/main_cubit.dart'
    as _i760;
import '../../features/user/notifications/data/datasources/notification_remote_data_source.dart'
    as _i419;
import '../../features/user/notifications/data/repositories/notification_repository_impl.dart'
    as _i602;
import '../../features/user/notifications/domain/repositories/notification_repository.dart'
    as _i92;
import '../../features/user/notifications/domain/usecases/get_notification_count_use_case.dart'
    as _i941;
import '../../features/user/notifications/domain/usecases/get_notification_list_use_case.dart'
    as _i804;
import '../../features/user/notifications/domain/usecases/mark_all_as_read_use_case.dart'
    as _i973;
import '../../features/user/notifications/presentation/cubit/notifications_cubit.dart'
    as _i329;
import '../../features/user/order/data/datasources/order_locale_data_source.dart'
    as _i291;
import '../../features/user/order/data/datasources/order_remote_data_source.dart'
    as _i342;
import '../../features/user/order/data/repositories/order_repo_impl.dart'
    as _i492;
import '../../features/user/order/domain/repositories/order_repository.dart'
    as _i205;
import '../../features/user/order/domain/usecases/add_product_to_cart_use_case.dart'
    as _i326;
import '../../features/user/order/domain/usecases/apply_promo_code_use_case.dart'
    as _i586;
import '../../features/user/order/domain/usecases/delete_order_use_case.dart'
    as _i507;
import '../../features/user/order/domain/usecases/delete_product_from_cart_list.dart'
    as _i1007;
import '../../features/user/order/domain/usecases/get_cart_list_use_case.dart'
    as _i204;
import '../../features/user/order/domain/usecases/get_delivery_cost_use_case.dart'
    as _i748;
import '../../features/user/order/domain/usecases/get_order_details_use_case.dart'
    as _i646;
import '../../features/user/order/domain/usecases/get_order_list_use_case.dart'
    as _i55;
import '../../features/user/order/domain/usecases/order_place_use_case.dart'
    as _i364;
import '../../features/user/order/domain/usecases/set_quantity_use_case.dart'
    as _i18;
import '../../features/user/order/presentation/bloc/cart/cart_cubit.dart'
    as _i462;
import '../../features/user/order/presentation/bloc/orders/orders_cubit.dart'
    as _i881;
import '../../features/user/order/presentation/bloc/rating/rating_cubit.dart'
    as _i847;
import '../../features/user/order/presentation/bloc/track/track_order_cubit.dart'
    as _i121;
import '../../features/user/payment/data/datasources/payment_remote_data_source.dart'
    as _i785;
import '../../features/user/payment/data/repositories/payment_repository_impl.dart'
    as _i19;
import '../../features/user/payment/domain/repositories/payment_repository.dart'
    as _i236;
import '../../features/user/payment/domain/usecases/add_balance_use_case.dart'
    as _i49;
import '../../features/user/payment/domain/usecases/get_current_balance_use_case.dart'
    as _i659;
import '../../features/user/payment/domain/usecases/get_transaction_use_case.dart'
    as _i303;
import '../../features/user/payment/presentation/bloc/balance/balance_cubit.dart'
    as _i709;
import '../../features/user/payment/presentation/bloc/wallet/wallet_cubit.dart'
    as _i23;
import '../../features/user/product/data/datasources/product_remote_data_source.dart'
    as _i953;
import '../../features/user/product/data/repositories/product_repository_impl.dart'
    as _i312;
import '../../features/user/product/domain/repositories/product_repository.dart'
    as _i576;
import '../../features/user/product/domain/usecases/get_favourite_use_case.dart'
    as _i428;
import '../../features/user/product/domain/usecases/get_product_details_use_case.dart'
    as _i352;
import '../../features/user/product/domain/usecases/get_products_use_case.dart'
    as _i67;
import '../../features/user/product/domain/usecases/get_suppliers_product_use_case.dart'
    as _i786;
import '../../features/user/product/domain/usecases/submit_review_use_case.dart'
    as _i208;
import '../../features/user/product/domain/usecases/toggle_wishlist_use_case.dart'
    as _i789;
import '../../features/user/product/presentation/cubit/favourite/favourite_cubit.dart'
    as _i1025;
import '../../features/user/product/presentation/cubit/product/product_cubit.dart'
    as _i910;
import '../../features/user/product/presentation/cubit/product_details/product_details_cubit.dart'
    as _i1065;
import '../../features/user/search/presentation/cubit/filter/filter_cubit.dart'
    as _i715;
import '../../features/user/supplier/data/datasources/supplier_remote_data_source.dart'
    as _i275;
import '../../features/user/supplier/data/repositories/suppliers_repository_impl.dart'
    as _i532;
import '../../features/user/supplier/domain/repositories/suppliers_repository.dart'
    as _i44;
import '../../features/user/supplier/domain/usecases/get_supplier_category_use_case.dart'
    as _i260;
import '../../features/user/supplier/domain/usecases/get_supplier_details_category_use_case.dart'
    as _i548;
import '../../features/user/supplier/presentation/cubit/supplier_cubit.dart'
    as _i380;
import '../../features/user/supplier/presentation/cubit/supplier_details/supplier_details_bloc.dart'
    as _i761;
import '../../features/user/trip/data/datasources/trip_remote_data_source.dart'
    as _i844;
import '../../features/user/trip/data/repositories/trip_repository_impl.dart'
    as _i359;
import '../../features/user/trip/domain/repositories/trip_repository.dart'
    as _i742;
import '../../features/user/trip/domain/usecases/cancel_trip_use_case.dart'
    as _i991;
import '../../features/user/trip/domain/usecases/get_all_trips_history_use_case.dart'
    as _i453;
import '../../features/user/trip/domain/usecases/get_trip_by_id_use_case.dart'
    as _i623;
import '../../features/user/trip/domain/usecases/get_trip_by_uuid_use_case.dart'
    as _i1003;
import '../../features/user/trip/domain/usecases/get_user_driver_use_case.dart'
    as _i45;
import '../../features/user/trip/domain/usecases/make_trip_use_case.dart'
    as _i840;
import '../../features/user/trip/domain/usecases/report_trip_issue_use_case.dart'
    as _i238;
import '../../features/user/trip/domain/usecases/search_trip_use_case.dart'
    as _i284;
import '../../features/user/trip/domain/usecases/send_payment_request_use_case.dart'
    as _i13;
import '../../features/user/trip/domain/usecases/send_trip_review_use_case.dart'
    as _i86;
import '../../features/user/trip/presentation/bloc/accepted_user_trip/accepted_user_trip_cubit.dart'
    as _i181;
import '../../features/user/trip/presentation/bloc/driver_history/trip_history_details_cubit.dart'
    as _i492;
import '../../features/user/trip/presentation/bloc/report_issue/report_issue_bloc.dart'
    as _i374;
import '../../features/user/trip/presentation/bloc/request_trip/request_trip_info_bloc.dart'
    as _i930;
import '../../features/user/trip/presentation/bloc/searching_for_driver/searching_for_driver_bloc.dart'
    as _i743;
import '../../features/user/trip/presentation/bloc/trip_actions_cubit.dart'
    as _i325;
import '../../features/user/trip/presentation/bloc/trip_history/trip_history_cubit.dart'
    as _i475;
import '../../features/user/trip/presentation/bloc/trip_info/trip_bloc.dart'
    as _i351;
import '../../features/user/trip/presentation/bloc/trip_payment_user/trip_payment_user_cubit.dart'
    as _i658;
import '../../features/user/trip/presentation/bloc/trip_rating/trip_rating_bloc.dart'
    as _i563;
import '../../features/vendor/attributes/data/datasources/attributes_remote_data_source.dart'
    as _i748;
import '../../features/vendor/attributes/data/repositories/attributes_repository_impl.dart'
    as _i366;
import '../../features/vendor/attributes/domain/repositories/attributes_repository.dart'
    as _i81;
import '../../features/vendor/attributes/domain/usecases/add_attribute_use_case.dart'
    as _i986;
import '../../features/vendor/attributes/domain/usecases/delete_attribute_use_case.dart'
    as _i554;
import '../../features/vendor/attributes/domain/usecases/get_attributes_use_case.dart'
    as _i1050;
import '../../features/vendor/attributes/domain/usecases/update_attribute_use_case.dart'
    as _i12;
import '../../features/vendor/attributes/domain/usecases/upload_sub_attribute_use_case.dart'
    as _i769;
import '../../features/vendor/attributes/presentation/cubit/attributes_cubit.dart'
    as _i34;
import '../../features/vendor/attributes/presentation/cubit/sub_attribute/sub_attributes_cubit.dart'
    as _i331;
import '../../features/vendor/auth/data/datasources/auth_remote_data_source.dart'
    as _i698;
import '../../features/vendor/auth/data/repositories/auth_repo_impl.dart'
    as _i946;
import '../../features/vendor/auth/domain/repositories/auth_repository.dart'
    as _i1062;
import '../../features/vendor/auth/domain/usecases/get_supplier_category_use_case.dart'
    as _i577;
import '../../features/vendor/auth/domain/usecases/get_user_data_use_case.dart'
    as _i314;
import '../../features/vendor/auth/domain/usecases/login_user_use_case.dart'
    as _i919;
import '../../features/vendor/auth/domain/usecases/register_user_use_case.dart'
    as _i466;
import '../../features/vendor/auth/presentation/cubit/complete_register/complete_register_bloc.dart'
    as _i734;
import '../../features/vendor/auth/presentation/cubit/login_cubit/login_cubit.dart'
    as _i129;
import '../../features/vendor/categories/data/datasources/categories_remote_data_source.dart'
    as _i997;
import '../../features/vendor/categories/data/repositories/categories_repository_impl.dart'
    as _i10;
import '../../features/vendor/categories/domain/repositories/categories_repository.dart'
    as _i11;
import '../../features/vendor/categories/domain/usecases/add_category_use_case.dart'
    as _i169;
import '../../features/vendor/categories/domain/usecases/delete_category_use_case.dart'
    as _i770;
import '../../features/vendor/categories/domain/usecases/get_categories_use_case.dart'
    as _i305;
import '../../features/vendor/categories/domain/usecases/update_category_use_case.dart'
    as _i1012;
import '../../features/vendor/categories/presentation/cubit/categories_cubit.dart'
    as _i85;
import '../../features/vendor/categories/presentation/cubit/details/category_details_cubit.dart'
    as _i185;
import '../../features/vendor/chat/data/datasources/chats_remote_data_source.dart'
    as _i967;
import '../../features/vendor/chat/data/repositories/chats_repository_impl.dart'
    as _i666;
import '../../features/vendor/chat/domain/repositories/chats_repoitory.dart'
    as _i466;
import '../../features/vendor/chat/domain/usecases/get_chat_message_use_case.dart'
    as _i816;
import '../../features/vendor/chat/domain/usecases/send_chat_use_case.dart'
    as _i122;
import '../../features/vendor/chat/presentation/bloc/message/message_bloc.dart'
    as _i468;
import '../../features/vendor/location/data/datasources/location_local_data_source.dart'
    as _i298;
import '../../features/vendor/location/data/datasources/location_remote_data_source.dart'
    as _i444;
import '../../features/vendor/location/data/repositories/location_repository_impl.dart'
    as _i598;
import '../../features/vendor/location/domain/repositories/location_repository.dart'
    as _i411;
import '../../features/vendor/location/domain/usecases/get_governorates_use_case.dart'
    as _i333;
import '../../features/vendor/location/domain/usecases/get_region_use_case.dart'
    as _i230;
import '../../features/vendor/location/presentation/cubit/governorate/governorate_bloc.dart'
    as _i1001;
import '../../features/vendor/location/presentation/cubit/location_cubit.dart'
    as _i248;
import '../../features/vendor/main/data/datasources/main_remote_data_source.dart'
    as _i1068;
import '../../features/vendor/main/data/repositories/main_repository_impl.dart'
    as _i281;
import '../../features/vendor/main/domain/repositories/main_repository.dart'
    as _i547;
import '../../features/vendor/main/domain/usecases/toggle_availability_use_case.dart'
    as _i239;
import '../../features/vendor/main/presentation/cubit/availitiablity/availitiablity_cubit.dart'
    as _i1033;
import '../../features/vendor/main/presentation/cubit/delivery_main/delivery_main_cubit.dart'
    as _i288;
import '../../features/vendor/order/data/datasources/delivery_remote_data_source.dart'
    as _i359;
import '../../features/vendor/order/data/repositories/delivery_orders_repository.dart'
    as _i889;
import '../../features/vendor/order/domain/repositories/delivery_orders_repository.dart'
    as _i839;
import '../../features/vendor/order/domain/usecases/get_all_delivery_orders_use_case.dart'
    as _i854;
import '../../features/vendor/order/domain/usecases/get_order_details_use_case.dart'
    as _i495;
import '../../features/vendor/order/domain/usecases/get_statics_use_case.dart'
    as _i966;
import '../../features/vendor/order/domain/usecases/reject_delivery_order_use_case.dart'
    as _i77;
import '../../features/vendor/order/domain/usecases/update_delivery_order_use_case.dart'
    as _i17;
import '../../features/vendor/order/presentation/cubit/delivery_actions/delivery_actions_cubit.dart'
    as _i394;
import '../../features/vendor/order/presentation/cubit/delivery_order_cubit.dart'
    as _i407;
import '../../features/vendor/order/presentation/cubit/statics/statics_cubit.dart'
    as _i378;
import '../../features/vendor/order/presentation/cubit/track/track_order_cubit.dart'
    as _i252;
import '../../features/vendor/product/data/datasources/product_remote_data_source.dart'
    as _i279;
import '../../features/vendor/product/data/repositories/product_repository.dart'
    as _i66;
import '../../features/vendor/product/presentation/cubit/product_cubit.dart'
    as _i984;
import '../../features/vendor/product/presentation/cubit/review/rating_cubit.dart'
    as _i464;
import '../helper/device_helper.dart' as _i620;
import '../helper/firebase/firebase_analytics_impl.dart' as _i864;
import '../helper/token_repository.dart' as _i734;
import 'external.dart' as _i379;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i361.Dio>(() => registerModule.dio);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i895.Connectivity>(() => registerModule.connectivity);
    gh.factory<_i181.AppInterceptors>(() => registerModule.app);
    gh.factory<_i892.FirebaseMessaging>(() => registerModule.firebaseMessaging);
    gh.factory<_i398.FirebaseAnalytics>(() => registerModule.firebaseAnalytics);
    gh.factory<_i558.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage,
    );
    gh.factory<_i183.ImagePicker>(() => registerModule.imagePicker);
    gh.factory<_i791.PolyLineHelper>(() => _i791.PolyLineHelper());
    gh.factory<_i665.ApiErrorHandler>(() => _i665.ApiErrorHandler());
    gh.factory<_i645.LocationPickerCubit>(() => _i645.LocationPickerCubit());
    gh.factory<_i248.LocationCubit>(() => _i248.LocationCubit());
    gh.lazySingleton<_i985.SocketService>(() => _i985.SocketService());
    gh.factory<_i1035.NetworkInfo>(() => _i1035.NetworkInfoImpl());
    gh.factory<_i913.GlobalCubit>(
      () => _i913.GlobalCubit(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i864.AnalyticsProvider>(
      () => _i864.FirebaseAnalyticsProvider(gh<_i398.FirebaseAnalytics>()),
    );
    gh.factory<_i620.DeviceHelper>(() => _i620.DeviceHelperImpl());
    gh.factory<_i277.TripHistoryDetailsCubit>(
      () => _i277.TripHistoryDetailsCubit(gh<_i791.PolyLineHelper>()),
    );
    gh.factory<_i492.TripHistoryDetailsCubit>(
      () => _i492.TripHistoryDetailsCubit(gh<_i791.PolyLineHelper>()),
    );
    gh.lazySingleton<_i82.DioConsumer>(
      () => _i82.DioConsumer(
        client: gh<_i361.Dio>(),
        apiErrorHandler: gh<_i665.ApiErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i419.NotificationRemoteDataSource>(
      () => _i419.NotificationRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.lazySingleton<_i275.SuppliersRemoteDataSource>(
      () => _i275.SuppliersRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i967.DriverMainRemoteDataSource>(
      () => _i967.DriverMainRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i844.TripRemoteDataSource>(
      () => _i844.TripRemoteDataSourceImpl(dioConsumer: gh<_i82.DioConsumer>()),
    );
    gh.lazySingleton<_i748.AttributesRemoteDataSource>(
      () => _i748.AttributesRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i564.LocationLocalDataSource>(
      () => _i564.LocationLocalDataSourceImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i298.LocationLocalDataSource>(
      () => _i298.LocationLocalDataSourceImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i967.ChatsRemoteDataSource>(
      () => _i967.ChatsRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        socketService: gh<_i985.SocketService>(),
      ),
    );
    gh.factory<_i734.TokenRepository>(
      () => _i734.TokenRepositoryImp(
        secureStorage: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.factory<_i731.DriverTripRemoteDataSource>(
      () => _i731.DriverTripRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.lazySingleton<_i342.OrderRemoteDataSource>(
      () =>
          _i342.OrderRemoteDataSourceImpl(dioConsumer: gh<_i82.DioConsumer>()),
    );
    gh.lazySingleton<_i997.CategoriesRemoteDataSource>(
      () => _i997.CategoriesRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i279.ProductRemoteDataSource>(
      () => _i279.ProductRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.lazySingleton<_i11.CategoriesRepository>(
      () => _i10.CategoriesRepositoryImpl(
        remoteDataSource: gh<_i997.CategoriesRemoteDataSource>(),
      ),
    );
    gh.factory<_i742.TripRepository>(
      () => _i359.TripRepositoryImpl(
        tripRemoteDataSource: gh<_i844.TripRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i577.SettingsRemoteDataSource>(
      () => _i577.SettingsRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i453.GetAllTripsHistoryUseCase>(
      () => _i453.GetAllTripsHistoryUseCase(gh<_i742.TripRepository>()),
    );
    gh.factory<_i238.ReportTripIssueUseCase>(
      () => _i238.ReportTripIssueUseCase(gh<_i742.TripRepository>()),
    );
    gh.factory<_i86.SendTripReviewUseCase>(
      () => _i86.SendTripReviewUseCase(gh<_i742.TripRepository>()),
    );
    gh.lazySingleton<_i676.AppRemoteDataSource>(
      () => _i676.AppRemoteDataSourceImpl(dioConsumer: gh<_i82.DioConsumer>()),
    );
    gh.factory<_i444.LocationRemoteDataSource>(
      () => _i444.LocationRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i700.DriverTripRepository>(
      () => _i649.DriverRepositoryRepository(
        driverTripRemoteDataSource: gh<_i731.DriverTripRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i953.ProductRemoteDataSource>(
      () => _i953.ProductRemoteDatasourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i1068.DriverMainRemoteDataSource>(
      () => _i1068.DriverMainRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i374.ReportIssueBloc>(
      () => _i374.ReportIssueBloc(gh<_i238.ReportTripIssueUseCase>()),
    );
    gh.factory<_i581.ChatsRemoteDataSource>(
      () => _i581.ChatsRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        socketService: gh<_i985.SocketService>(),
      ),
    );
    gh.lazySingleton<_i904.NotificationRemoteDataSource>(
      () => _i904.NotificationRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i449.LocationRemoteDataSource>(
      () => _i449.LocationRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.lazySingleton<_i511.AuthRemoteDataSource>(
      () => _i511.AuthRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
        tokenRepository: gh<_i734.TokenRepository>(),
        deviceHelper: gh<_i620.DeviceHelper>(),
      ),
    );
    gh.lazySingleton<_i785.PaymentRemoteDataSource>(
      () => _i785.PaymentRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.lazySingleton<_i81.AppRepository>(
      () => _i657.AppRepositoryImpl(
        appRemoteDataSource: gh<_i676.AppRemoteDataSource>(),
      ),
    );
    gh.factory<_i771.SocketCubit>(
      () => _i771.SocketCubit(
        gh<_i985.SocketService>(),
        gh<_i734.TokenRepository>(),
      ),
    );
    gh.lazySingleton<_i66.ProductRepository>(
      () => _i66.ProductRepository(
        remoteDataSource: gh<_i279.ProductRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i576.ProductRepository>(
      () => _i312.ProductRepositoryImpl(
        productRemoteDataSource: gh<_i953.ProductRemoteDataSource>(),
      ),
    );
    gh.factory<_i995.LocationRepository>(
      () => _i732.LocationRepositoryImpl(
        locationRemoteDataSource: gh<_i449.LocationRemoteDataSource>(),
        locationLocalDataSource: gh<_i564.LocationLocalDataSource>(),
      ),
    );
    gh.factory<_i689.ChatsRepository>(
      () => _i1011.ChatsRepositoryImpl(
        chatsRemoteDataSource: gh<_i581.ChatsRemoteDataSource>(),
        networkInfo: gh<_i1035.NetworkInfo>(),
      ),
    );
    gh.lazySingleton<_i81.AttributesRepository>(
      () => _i366.AttributesRepositoryImpl(
        remoteDataSource: gh<_i748.AttributesRemoteDataSource>(),
      ),
    );
    gh.factory<_i466.ChatsRepository>(
      () => _i666.ChatsRepositoryImpl(
        chatsRemoteDataSource: gh<_i967.ChatsRemoteDataSource>(),
        networkInfo: gh<_i1035.NetworkInfo>(),
      ),
    );
    gh.factory<_i375.GetPlaceDetailsByLatlng>(
      () => _i375.GetPlaceDetailsByLatlng(
        locationRepository: gh<_i995.LocationRepository>(),
      ),
    );
    gh.factory<_i182.GetGovernoratesUseCase>(
      () => _i182.GetGovernoratesUseCase(
        locationRepository: gh<_i995.LocationRepository>(),
      ),
    );
    gh.factory<_i547.GetPlaceDetailsByPlaceIdUseCase>(
      () => _i547.GetPlaceDetailsByPlaceIdUseCase(
        locationRepository: gh<_i995.LocationRepository>(),
      ),
    );
    gh.factory<_i979.UpdateDriverLocationUseCase>(
      () => _i979.UpdateDriverLocationUseCase(
        locationRepository: gh<_i995.LocationRepository>(),
      ),
    );
    gh.factory<_i440.DeleteImageUseCase>(
      () => _i440.DeleteImageUseCase(appRepository: gh<_i81.AppRepository>()),
    );
    gh.factory<_i439.GenerateDeepLink>(
      () => _i439.GenerateDeepLink(appRepository: gh<_i81.AppRepository>()),
    );
    gh.factory<_i656.UploadImageUseCase>(
      () => _i656.UploadImageUseCase(appRepository: gh<_i81.AppRepository>()),
    );
    gh.lazySingleton<_i708.LocationRemoteDataSource>(
      () => _i708.LocationRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i752.DriverMainRepository>(
      () => _i547.DriverMainRepositoryImpl(
        mainRemoteDataSource: gh<_i967.DriverMainRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i30.SettingsRepository>(
      () => _i859.SettingsRepositoryImpl(
        settingsRemoteDataSource: gh<_i577.SettingsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i236.PaymentRepository>(
      () => _i19.PaymentRepositoryImpl(
        paymentRemoteDataSource: gh<_i785.PaymentRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i988.PickImageCubit>(
      () => _i988.PickImageCubit(
        gh<_i656.UploadImageUseCase>(),
        gh<_i440.DeleteImageUseCase>(),
      ),
    );
    gh.lazySingleton<_i305.GetCategoriesUseCase>(
      () => _i305.GetCategoriesUseCase(
        repository: gh<_i11.CategoriesRepository>(),
      ),
    );
    gh.factory<_i169.AddCategoryUseCase>(
      () =>
          _i169.AddCategoryUseCase(repository: gh<_i11.CategoriesRepository>()),
    );
    gh.factory<_i770.DeleteCategoryUseCase>(
      () => _i770.DeleteCategoryUseCase(
        repository: gh<_i11.CategoriesRepository>(),
      ),
    );
    gh.factory<_i1012.UpdateCategoryUseCase>(
      () => _i1012.UpdateCategoryUseCase(
        repository: gh<_i11.CategoriesRepository>(),
      ),
    );
    gh.lazySingleton<_i44.SuppliersRepository>(
      () => _i532.SuppliersRepositoryImpl(
        suppliersRemoteDataSource: gh<_i275.SuppliersRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i372.UpdateTripStatusUseCase>(
      () => _i372.UpdateTripStatusUseCase(
        driverTripRepository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.factory<_i353.AcceptDriverPaymentRequestUseCase>(
      () => _i353.AcceptDriverPaymentRequestUseCase(
        driverTripRepository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.factory<_i399.AcceptTripUseCase>(
      () => _i399.AcceptTripUseCase(
        driverTripRepository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.factory<_i567.CancelDriverTripUseCase>(
      () => _i567.CancelDriverTripUseCase(
        driverTripRepository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.factory<_i1065.EndDriverTripUseCase>(
      () => _i1065.EndDriverTripUseCase(
        driverTripRepository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.factory<_i425.GetTripByIdUseCase>(
      () => _i425.GetTripByIdUseCase(
        driverTripRepository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.factory<_i612.RejectTripUseCase>(
      () => _i612.RejectTripUseCase(
        driverTripRepository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.lazySingleton<_i428.GetFavouriteUseCase>(
      () => _i428.GetFavouriteUseCase(
        productRepository: gh<_i576.ProductRepository>(),
      ),
    );
    gh.lazySingleton<_i352.GetProductDetailsUseCase>(
      () => _i352.GetProductDetailsUseCase(
        productRepository: gh<_i576.ProductRepository>(),
      ),
    );
    gh.lazySingleton<_i67.GetProductUseCase>(
      () => _i67.GetProductUseCase(
        productRepository: gh<_i576.ProductRepository>(),
      ),
    );
    gh.lazySingleton<_i786.GetSuppliersProductUseCase>(
      () => _i786.GetSuppliersProductUseCase(
        productRepository: gh<_i576.ProductRepository>(),
      ),
    );
    gh.lazySingleton<_i208.SubmitReviewUseCase>(
      () => _i208.SubmitReviewUseCase(
        productRepository: gh<_i576.ProductRepository>(),
      ),
    );
    gh.lazySingleton<_i789.ToggleWishlistUseCase>(
      () => _i789.ToggleWishlistUseCase(
        productRepository: gh<_i576.ProductRepository>(),
      ),
    );
    gh.lazySingleton<_i49.AddBalanceUseCase>(
      () => _i49.AddBalanceUseCase(
        paymentRepository: gh<_i236.PaymentRepository>(),
      ),
    );
    gh.lazySingleton<_i659.GetCurrentBalanceUseCase>(
      () => _i659.GetCurrentBalanceUseCase(
        paymentRepository: gh<_i236.PaymentRepository>(),
      ),
    );
    gh.lazySingleton<_i303.GetTransactionUseCase>(
      () => _i303.GetTransactionUseCase(
        paymentRepository: gh<_i236.PaymentRepository>(),
      ),
    );
    gh.factory<_i23.WalletCubit>(
      () => _i23.WalletCubit(
        gh<_i303.GetTransactionUseCase>(),
        gh<_i659.GetCurrentBalanceUseCase>(),
      ),
    );
    gh.lazySingleton<_i7.AuthRepository>(
      () => _i384.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i511.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i411.LocationRepository>(
      () => _i598.LocationRepositoryImpl(
        locationRemoteDataSource: gh<_i444.LocationRemoteDataSource>(),
        locationLocalDataSource: gh<_i298.LocationLocalDataSource>(),
      ),
    );
    gh.factory<_i475.TripHistoryCubit>(
      () => _i475.TripHistoryCubit(gh<_i453.GetAllTripsHistoryUseCase>()),
    );
    gh.factory<_i315.ToggleAvailabilityUseCase>(
      () => _i315.ToggleAvailabilityUseCase(
        mainRepository: gh<_i752.DriverMainRepository>(),
      ),
    );
    gh.factory<_i991.CancelTripUseCase>(
      () => _i991.CancelTripUseCase(tripRepository: gh<_i742.TripRepository>()),
    );
    gh.factory<_i45.GetUserDriverUseCase>(
      () =>
          _i45.GetUserDriverUseCase(tripRepository: gh<_i742.TripRepository>()),
    );
    gh.factory<_i840.MakeTripUseCase>(
      () => _i840.MakeTripUseCase(tripRepository: gh<_i742.TripRepository>()),
    );
    gh.lazySingleton<_i13.SendUserPaymentRequestUseCase>(
      () => _i13.SendUserPaymentRequestUseCase(
        tripRepository: gh<_i742.TripRepository>(),
      ),
    );
    gh.factory<_i698.AuthRemoteDataSource>(
      () => _i698.AuthRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        tokenRepository: gh<_i734.TokenRepository>(),
        deviceHelper: gh<_i620.DeviceHelper>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i707.GetAllTripsHistoryUseCase>(
      () => _i707.GetAllTripsHistoryUseCase(gh<_i700.DriverTripRepository>()),
    );
    gh.lazySingleton<_i945.PendingTripsUseCase>(
      () => _i945.PendingTripsUseCase(
        repository: gh<_i700.DriverTripRepository>(),
      ),
    );
    gh.factory<_i847.RatingCubit>(
      () => _i847.RatingCubit(gh<_i208.SubmitReviewUseCase>()),
    );
    gh.lazySingleton<_i291.OrderLocaleDataSource>(
      () => _i291.OrderLocaleDataSourceImpl(
        sharedPreferences: gh<_i460.SharedPreferences>(),
        remoteDataSource: gh<_i342.OrderRemoteDataSource>(),
      ),
    );
    gh.factory<_i1065.ProductDetailsCubit>(
      () => _i1065.ProductDetailsCubit(
        gh<_i352.GetProductDetailsUseCase>(),
        gh<_i789.ToggleWishlistUseCase>(),
      ),
    );
    gh.factory<_i563.TripRatingBloc>(
      () => _i563.TripRatingBloc(gh<_i86.SendTripReviewUseCase>()),
    );
    gh.lazySingleton<_i380.DeliveryRemoteDataSource>(
      () => _i380.DeliveryRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.factory<_i31.ChatsRemoteDataSource>(
      () => _i31.ChatsRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        socketService: gh<_i985.SocketService>(),
      ),
    );
    gh.factory<_i785.PaymentConfirmationCubit>(
      () => _i785.PaymentConfirmationCubit(
        gh<_i985.SocketService>(),
        gh<_i353.AcceptDriverPaymentRequestUseCase>(),
      ),
    );
    gh.lazySingleton<_i359.DeliveryRemoteDataSource>(
      () => _i359.DeliveryRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.lazySingleton<_i92.NotificationRepository>(
      () => _i602.NotificationRepositoryImpl(
        networkInfo: gh<_i1035.NetworkInfo>(),
        remoteMainDataSource: gh<_i419.NotificationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i14.MainRemoteDataSource>(
      () => _i14.MainRemoteDataSourceImpl(dioConsumer: gh<_i82.DioConsumer>()),
    );
    gh.lazySingleton<_i769.UploadSubAttributeUseCase>(
      () => _i769.UploadSubAttributeUseCase(
        attributesRepository: gh<_i81.AttributesRepository>(),
      ),
    );
    gh.factory<_i843.DriverMainRemoteDataSource>(
      () => _i843.DriverMainRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
      ),
    );
    gh.lazySingleton<_i728.DeleteAccountUseCase>(
      () =>
          _i728.DeleteAccountUseCase(authRepository: gh<_i7.AuthRepository>()),
    );
    gh.lazySingleton<_i477.GetUserDataUseCase>(
      () => _i477.GetUserDataUseCase(authRepository: gh<_i7.AuthRepository>()),
    );
    gh.lazySingleton<_i543.LogOutUseCase>(
      () => _i543.LogOutUseCase(authRepository: gh<_i7.AuthRepository>()),
    );
    gh.lazySingleton<_i665.LoginUserUseCase>(
      () => _i665.LoginUserUseCase(authRepository: gh<_i7.AuthRepository>()),
    );
    gh.lazySingleton<_i145.UpdateUserDataUseCase>(
      () =>
          _i145.UpdateUserDataUseCase(authRepository: gh<_i7.AuthRepository>()),
    );
    gh.lazySingleton<_i333.VerifyOtpUseCase>(
      () => _i333.VerifyOtpUseCase(authRepository: gh<_i7.AuthRepository>()),
    );
    gh.factory<_i8.GovernorateBloc>(
      () => _i8.GovernorateBloc(gh<_i182.GetGovernoratesUseCase>()),
    );
    gh.lazySingleton<_i663.ChangeLangCodeUseCase>(
      () => _i663.ChangeLangCodeUseCase(
        settingsRepository: gh<_i30.SettingsRepository>(),
      ),
    );
    gh.lazySingleton<_i1067.GetAppSettingsUseCase>(
      () => _i1067.GetAppSettingsUseCase(
        settingsRepository: gh<_i30.SettingsRepository>(),
      ),
    );
    gh.lazySingleton<_i224.GetDeletionReasonsUseCase>(
      () => _i224.GetDeletionReasonsUseCase(
        settingsRepository: gh<_i30.SettingsRepository>(),
      ),
    );
    gh.lazySingleton<_i545.GetAllFaqsUseCase>(
      () => _i545.GetAllFaqsUseCase(
        settingsRepository: gh<_i30.SettingsRepository>(),
      ),
    );
    gh.lazySingleton<_i297.GetPageUseCase>(
      () => _i297.GetPageUseCase(
        settingsRepository: gh<_i30.SettingsRepository>(),
      ),
    );
    gh.lazySingleton<_i779.NotificationRepository>(
      () => _i527.NotificationRepositoryImpl(
        networkInfo: gh<_i1035.NetworkInfo>(),
        remoteMainDataSource: gh<_i904.NotificationRemoteDataSource>(),
      ),
    );
    gh.factory<_i460.LogoutCubit>(
      () => _i460.LogoutCubit(gh<_i543.LogOutUseCase>()),
    );
    gh.lazySingleton<_i284.SearchTripUseCase>(
      () => _i284.SearchTripUseCase(repository: gh<_i742.TripRepository>()),
    );
    gh.factory<_i658.TripPaymentUserCubit>(
      () => _i658.TripPaymentUserCubit(
        gh<_i985.SocketService>(),
        gh<_i13.SendUserPaymentRequestUseCase>(),
      ),
    );
    gh.factory<_i56.AuthRemoteDataSource>(
      () => _i56.AuthRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        tokenRepository: gh<_i734.TokenRepository>(),
        deviceHelper: gh<_i620.DeviceHelper>(),
      ),
    );
    gh.factory<_i910.ProductCubit>(
      () => _i910.ProductCubit(
        gh<_i67.GetProductUseCase>(),
        gh<_i786.GetSuppliersProductUseCase>(),
      ),
    );
    gh.lazySingleton<_i623.GetTripByIdUseCase>(
      () => _i623.GetTripByIdUseCase(
        driverTripRepository: gh<_i742.TripRepository>(),
      ),
    );
    gh.factory<_i1003.GetTripByUUidUseCase>(
      () => _i1003.GetTripByUUidUseCase(
        driverTripRepository: gh<_i742.TripRepository>(),
      ),
    );
    gh.factory<_i547.DriverMainRepository>(
      () => _i281.DriverMainRepositoryImpl(
        mainRemoteDataSource: gh<_i1068.DriverMainRemoteDataSource>(),
      ),
    );
    gh.factory<_i325.TripActionsCubit>(
      () => _i325.TripActionsCubit(gh<_i991.CancelTripUseCase>()),
    );
    gh.factory<_i639.AvailitiablityCubit>(
      () => _i639.AvailitiablityCubit(gh<_i315.ToggleAvailabilityUseCase>()),
    );
    gh.factory<_i1025.FavouriteCubit>(
      () => _i1025.FavouriteCubit(
        gh<_i428.GetFavouriteUseCase>(),
        gh<_i789.ToggleWishlistUseCase>(),
      ),
    );
    gh.factory<_i931.TripCubit>(
      () => _i931.TripCubit(
        gh<_i425.GetTripByIdUseCase>(),
        gh<_i985.SocketService>(),
      ),
    );
    gh.factory<_i709.BalanceCubit>(
      () => _i709.BalanceCubit(gh<_i49.AddBalanceUseCase>()),
    );
    gh.factory<_i333.GetGovernoratesUseCase>(
      () => _i333.GetGovernoratesUseCase(
        locationRepository: gh<_i411.LocationRepository>(),
      ),
    );
    gh.factory<_i230.GetRegionUseCase>(
      () => _i230.GetRegionUseCase(
        locationRepository: gh<_i411.LocationRepository>(),
      ),
    );
    gh.factory<_i417.GetChatMessagesUseCase>(
      () => _i417.GetChatMessagesUseCase(
        chatsRepository: gh<_i689.ChatsRepository>(),
      ),
    );
    gh.factory<_i1041.SendChatUseCase>(
      () =>
          _i1041.SendChatUseCase(chatsRepository: gh<_i689.ChatsRepository>()),
    );
    gh.factory<_i986.AddAttributeUseCase>(
      () => _i986.AddAttributeUseCase(
        repository: gh<_i81.AttributesRepository>(),
      ),
    );
    gh.factory<_i554.DeleteAttributeUseCase>(
      () => _i554.DeleteAttributeUseCase(
        repository: gh<_i81.AttributesRepository>(),
      ),
    );
    gh.factory<_i12.UpdateAttributeUseCase>(
      () => _i12.UpdateAttributeUseCase(
        repository: gh<_i81.AttributesRepository>(),
      ),
    );
    gh.lazySingleton<_i1050.GetAttributesUseCase>(
      () => _i1050.GetAttributesUseCase(
        repository: gh<_i81.AttributesRepository>(),
      ),
    );
    gh.factory<_i661.LoginCubit>(
      () => _i661.LoginCubit(gh<_i665.LoginUserUseCase>()),
    );
    gh.lazySingleton<_i150.GetNotificationsCount>(
      () => _i150.GetNotificationsCount(
        repository: gh<_i779.NotificationRepository>(),
      ),
    );
    gh.factory<_i438.TripHistoryCubit>(
      () => _i438.TripHistoryCubit(gh<_i707.GetAllTripsHistoryUseCase>()),
    );
    gh.factory<_i581.LocationCubit>(
      () => _i581.LocationCubit(gh<_i547.GetPlaceDetailsByPlaceIdUseCase>()),
    );
    gh.factory<_i816.GetChatMessagesUseCase>(
      () => _i816.GetChatMessagesUseCase(
        chatsRepository: gh<_i466.ChatsRepository>(),
      ),
    );
    gh.factory<_i122.SendChatUseCase>(
      () => _i122.SendChatUseCase(chatsRepository: gh<_i466.ChatsRepository>()),
    );
    gh.factory<_i930.RequestTripBloc>(
      () => _i930.RequestTripBloc(
        gh<_i840.MakeTripUseCase>(),
        gh<_i985.SocketService>(),
      ),
    );
    gh.factory<_i185.CategoryDetailsCubit>(
      () => _i185.CategoryDetailsCubit(gh<_i66.ProductRepository>()),
    );
    gh.factory<_i984.ProductCubit>(
      () => _i984.ProductCubit(gh<_i66.ProductRepository>()),
    );
    gh.factory<_i464.RatingCubit>(
      () => _i464.RatingCubit(gh<_i66.ProductRepository>()),
    );
    gh.lazySingleton<_i839.DeliveryOrdersRepository>(
      () => _i889.DeliveryOrdersRepositoryImpl(
        deliveryRemoteDataSource: gh<_i359.DeliveryRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i1043.InitRemoteDataSource>(
      () => _i1043.RegisterRemoteDataSourceImpl(
        dioConsumer: gh<_i82.DioConsumer>(),
        sharedPreferences: gh<_i460.SharedPreferences>(),
        tokenRepository: gh<_i734.TokenRepository>(),
        authRemoteDataSource: gh<_i56.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i623.ChatsRepository>(
      () => _i618.ChatsRepositoryImpl(
        chatsRemoteDataSource: gh<_i31.ChatsRemoteDataSource>(),
        networkInfo: gh<_i1035.NetworkInfo>(),
      ),
    );
    gh.factory<_i184.DriverLocationCubit>(
      () => _i184.DriverLocationCubit(
        gh<_i985.SocketService>(),
        gh<_i979.UpdateDriverLocationUseCase>(),
        gh<_i791.PolyLineHelper>(),
      ),
    );
    gh.lazySingleton<_i205.OrderRepository>(
      () => _i492.OrderRepoImpl(
        orderLocaleDataSource: gh<_i291.OrderLocaleDataSource>(),
        orderRemoteDataSource: gh<_i342.OrderRemoteDataSource>(),
      ),
    );
    gh.factory<_i194.AcceptedDriverCubit>(
      () => _i194.AcceptedDriverCubit(
        gh<_i985.SocketService>(),
        gh<_i979.UpdateDriverLocationUseCase>(),
        gh<_i567.CancelDriverTripUseCase>(),
        gh<_i1065.EndDriverTripUseCase>(),
        gh<_i372.UpdateTripStatusUseCase>(),
        gh<_i425.GetTripByIdUseCase>(),
        gh<_i353.AcceptDriverPaymentRequestUseCase>(),
      ),
    );
    gh.factory<_i468.MessageBloc>(
      () => _i468.MessageBloc(
        gh<_i122.SendChatUseCase>(),
        gh<_i816.GetChatMessagesUseCase>(),
        gh<_i985.SocketService>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i85.CategoriesCubit>(
      () => _i85.CategoriesCubit(
        gh<_i305.GetCategoriesUseCase>(),
        gh<_i169.AddCategoryUseCase>(),
        gh<_i1012.UpdateCategoryUseCase>(),
        gh<_i770.DeleteCategoryUseCase>(),
      ),
    );
    gh.factory<_i743.SearchingForDriverBloc>(
      () => _i743.SearchingForDriverBloc(
        gh<_i991.CancelTripUseCase>(),
        gh<_i985.SocketService>(),
        gh<_i623.GetTripByIdUseCase>(),
        gh<_i284.SearchTripUseCase>(),
        gh<_i1003.GetTripByUUidUseCase>(),
      ),
    );
    gh.lazySingleton<_i124.LocationRepository>(
      () => _i121.LocationRepositoryImpl(
        locationRemoteDataSource: gh<_i708.LocationRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i907.GetNotificationListUseCase>(
      () => _i907.GetNotificationListUseCase(
        notificationRepository: gh<_i779.NotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i107.MarkAllAsReadUseCase>(
      () => _i107.MarkAllAsReadUseCase(
        notificationRepository: gh<_i779.NotificationRepository>(),
      ),
    );
    gh.factory<_i381.DriverMainRepository>(
      () => _i63.DriverMainRepositoryImpl(
        mainRemoteDataSource: gh<_i843.DriverMainRemoteDataSource>(),
      ),
    );
    gh.factory<_i787.UpdateBloc>(
      () => _i787.UpdateBloc(
        gh<_i145.UpdateUserDataUseCase>(),
        gh<_i728.DeleteAccountUseCase>(),
      ),
    );
    gh.lazySingleton<_i260.GetSupplierCategoryUseCase>(
      () => _i260.GetSupplierCategoryUseCase(
        suppliersRepository: gh<_i44.SuppliersRepository>(),
      ),
    );
    gh.lazySingleton<_i548.GetSupplierDetailsCategoryUseCase>(
      () => _i548.GetSupplierDetailsCategoryUseCase(
        suppliersRepository: gh<_i44.SuppliersRepository>(),
      ),
    );
    gh.factory<_i234.DriverTripActionsCubit>(
      () => _i234.DriverTripActionsCubit(
        gh<_i399.AcceptTripUseCase>(),
        gh<_i985.SocketService>(),
        gh<_i612.RejectTripUseCase>(),
      ),
    );
    gh.lazySingleton<_i523.MainRepository>(
      () => _i450.MainRepositoryImpl(
        mainRemoteDataSource: gh<_i14.MainRemoteDataSource>(),
      ),
    );
    gh.factory<_i940.DriverHomeCubit>(
      () => _i940.DriverHomeCubit(
        gh<_i985.SocketService>(),
        gh<_i425.GetTripByIdUseCase>(),
        gh<_i945.PendingTripsUseCase>(),
      ),
    );
    gh.factory<_i475.AuthRepository>(
      () => _i478.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i56.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i239.ToggleAvailabilityUseCase>(
      () => _i239.ToggleAvailabilityUseCase(
        mainRepository: gh<_i547.DriverMainRepository>(),
      ),
    );
    gh.lazySingleton<_i609.GetBannersUseCase>(
      () => _i609.GetBannersUseCase(mainRepository: gh<_i523.MainRepository>()),
    );
    gh.lazySingleton<_i31.GetBrandUseCase>(
      () => _i31.GetBrandUseCase(mainRepository: gh<_i523.MainRepository>()),
    );
    gh.lazySingleton<_i45.GetMainCategoryUseCase>(
      () => _i45.GetMainCategoryUseCase(
        mainRepository: gh<_i523.MainRepository>(),
      ),
    );
    gh.factory<_i1.OtpBloc>(
      () => _i1.OtpBloc(gh<_i333.VerifyOtpUseCase>(), gh<_i620.DeviceHelper>()),
    );
    gh.lazySingleton<_i804.GetNotificationListUseCase>(
      () => _i804.GetNotificationListUseCase(
        notificationRepository: gh<_i92.NotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i973.MarkAllAsReadUseCase>(
      () => _i973.MarkAllAsReadUseCase(
        notificationRepository: gh<_i92.NotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i354.AddNewAddressUseCase>(
      () => _i354.AddNewAddressUseCase(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.lazySingleton<_i9.DeleteAddressUseCase>(
      () => _i9.DeleteAddressUseCase(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.lazySingleton<_i60.GetAddressUseCase>(
      () => _i60.GetAddressUseCase(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.lazySingleton<_i710.GetRegionUseCase>(
      () => _i710.GetRegionUseCase(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.lazySingleton<_i1036.MakeAddressDefaultUseCase>(
      () => _i1036.MakeAddressDefaultUseCase(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.factory<_i481.GetPlaceDetailsByLatlng>(
      () => _i481.GetPlaceDetailsByLatlng(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.factory<_i763.GetGoogleSuggestUseCase>(
      () => _i763.GetGoogleSuggestUseCase(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.factory<_i50.GetPlaceDetailsByPlaceIdUseCase>(
      () => _i50.GetPlaceDetailsByPlaceIdUseCase(
        locationRepository: gh<_i124.LocationRepository>(),
      ),
    );
    gh.factory<_i398.FaqsQuestionCubit>(
      () => _i398.FaqsQuestionCubit(gh<_i545.GetAllFaqsUseCase>()),
    );
    gh.factory<_i273.AddNewAddressCubit>(
      () => _i273.AddNewAddressCubit(gh<_i354.AddNewAddressUseCase>()),
    );
    gh.factory<_i1062.AuthRepository>(
      () => _i946.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i698.AuthRemoteDataSource>(),
        captain: gh<_i56.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i351.TripBloc>(
      () => _i351.TripBloc(
        gh<_i481.GetPlaceDetailsByLatlng>(),
        gh<_i791.PolyLineHelper>(),
        gh<_i45.GetUserDriverUseCase>(),
        gh<_i1003.GetTripByUUidUseCase>(),
      ),
    );
    gh.lazySingleton<_i577.GetSupplierCategoryUseCase>(
      () => _i577.GetSupplierCategoryUseCase(
        authRepository: gh<_i1062.AuthRepository>(),
      ),
    );
    gh.lazySingleton<_i314.GetUserDataUseCase>(
      () =>
          _i314.GetUserDataUseCase(authRepository: gh<_i1062.AuthRepository>()),
    );
    gh.factory<_i919.LoginUserUseCase>(
      () => _i919.LoginUserUseCase(authRepository: gh<_i1062.AuthRepository>()),
    );
    gh.factory<_i466.RegisterUserUseCase>(
      () => _i466.RegisterUserUseCase(
        authRepository: gh<_i1062.AuthRepository>(),
      ),
    );
    gh.factory<_i715.FilterCubit>(
      () => _i715.FilterCubit(gh<_i45.GetMainCategoryUseCase>()),
    );
    gh.lazySingleton<_i941.GetNotificationsCount>(
      () => _i941.GetNotificationsCount(
        repository: gh<_i92.NotificationRepository>(),
      ),
    );
    gh.factory<_i990.SettingsBloc>(
      () => _i990.SettingsBloc(gh<_i1067.GetAppSettingsUseCase>()),
    );
    gh.factory<_i515.GetChatMessagesUseCase>(
      () => _i515.GetChatMessagesUseCase(
        chatsRepository: gh<_i623.ChatsRepository>(),
      ),
    );
    gh.factory<_i1027.SendChatUseCase>(
      () =>
          _i1027.SendChatUseCase(chatsRepository: gh<_i623.ChatsRepository>()),
    );
    gh.factory<_i380.SupplierCubit>(
      () => _i380.SupplierCubit(gh<_i260.GetSupplierCategoryUseCase>()),
    );
    gh.lazySingleton<_i765.DeliveryOrdersRepository>(
      () => _i990.DeliveryOrdersRepositoryImpl(
        deliveryRemoteDataSource: gh<_i380.DeliveryRemoteDataSource>(),
      ),
    );
    gh.factory<_i131.UpdateFcmUseCase>(
      () => _i131.UpdateFcmUseCase(gh<_i475.AuthRepository>()),
    );
    gh.factory<_i882.PagesBloc>(
      () => _i882.PagesBloc(gh<_i297.GetPageUseCase>()),
    );
    gh.lazySingleton<_i495.GetOrderDetailsUseCase>(
      () => _i495.GetOrderDetailsUseCase(
        orderRepository: gh<_i839.DeliveryOrdersRepository>(),
      ),
    );
    gh.lazySingleton<_i378.AcceptDeliveryOrderUseCase>(
      () => _i378.AcceptDeliveryOrderUseCase(
        repository: gh<_i765.DeliveryOrdersRepository>(),
      ),
    );
    gh.lazySingleton<_i651.RejectDeliveryOrderUseCase>(
      () => _i651.RejectDeliveryOrderUseCase(
        repository: gh<_i765.DeliveryOrdersRepository>(),
      ),
    );
    gh.lazySingleton<_i90.UpdateDeliveryOrderUseCase>(
      () => _i90.UpdateDeliveryOrderUseCase(
        repository: gh<_i765.DeliveryOrdersRepository>(),
      ),
    );
    gh.lazySingleton<_i181.GetOrderDetailsUseCase>(
      () => _i181.GetOrderDetailsUseCase(
        orderRepository: gh<_i765.DeliveryOrdersRepository>(),
      ),
    );
    gh.factory<_i427.MessageBloc>(
      () => _i427.MessageBloc(
        gh<_i1041.SendChatUseCase>(),
        gh<_i417.GetChatMessagesUseCase>(),
        gh<_i985.SocketService>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i1001.GovernorateBloc>(
      () => _i1001.GovernorateBloc(
        gh<_i333.GetGovernoratesUseCase>(),
        gh<_i230.GetRegionUseCase>(),
      ),
    );
    gh.factory<_i1033.AvailitiablityCubit>(
      () => _i1033.AvailitiablityCubit(gh<_i239.ToggleAvailabilityUseCase>()),
    );
    gh.factory<_i181.AcceptedUserTripCubit>(
      () => _i181.AcceptedUserTripCubit(
        gh<_i985.SocketService>(),
        gh<_i623.GetTripByIdUseCase>(),
      ),
    );
    gh.factory<_i34.AttributesCubit>(
      () => _i34.AttributesCubit(
        gh<_i1050.GetAttributesUseCase>(),
        gh<_i986.AddAttributeUseCase>(),
        gh<_i12.UpdateAttributeUseCase>(),
        gh<_i554.DeleteAttributeUseCase>(),
      ),
    );
    gh.factory<_i329.NotificationsCubit>(
      () => _i329.NotificationsCubit(
        gh<_i804.GetNotificationListUseCase>(),
        gh<_i973.MarkAllAsReadUseCase>(),
        gh<_i941.GetNotificationsCount>(),
      ),
    );
    gh.lazySingleton<_i983.InitRepository>(
      () => _i740.InitRepoImpl(
        initRemoteDataSource: gh<_i1043.InitRemoteDataSource>(),
      ),
    );
    gh.factory<_i331.SubAttributesCubit>(
      () => _i331.SubAttributesCubit(
        gh<_i1050.GetAttributesUseCase>(),
        gh<_i769.UploadSubAttributeUseCase>(),
      ),
    );
    gh.factory<_i129.LoginCubit>(
      () => _i129.LoginCubit(gh<_i919.LoginUserUseCase>()),
    );
    gh.lazySingleton<_i1048.GetIntroDataUseCase>(
      () => _i1048.GetIntroDataUseCase(
        initRepository: gh<_i983.InitRepository>(),
      ),
    );
    gh.lazySingleton<_i598.InitAppUseCase>(
      () => _i598.InitAppUseCase(initRepository: gh<_i983.InitRepository>()),
    );
    gh.factory<_i586.ApplyPromoCodeUseCase>(
      () => _i586.ApplyPromoCodeUseCase(
        orderRepository: gh<_i205.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i326.AddProductToCartUseCase>(
      () => _i326.AddProductToCartUseCase(
        orderRepository: gh<_i205.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i507.DeleteOrderUseCase>(
      () => _i507.DeleteOrderUseCase(
        orderRepository: gh<_i205.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i1007.DeleteProductToCartUseCase>(
      () => _i1007.DeleteProductToCartUseCase(
        orderRepository: gh<_i205.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i204.GetCartListUse>(
      () => _i204.GetCartListUse(orderRepository: gh<_i205.OrderRepository>()),
    );
    gh.lazySingleton<_i748.GetDeliveryCostUseCase>(
      () => _i748.GetDeliveryCostUseCase(
        orderRepository: gh<_i205.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i646.GetOrderDetailsUseCase>(
      () => _i646.GetOrderDetailsUseCase(
        orderRepository: gh<_i205.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i55.GetOrderListUseCase>(
      () => _i55.GetOrderListUseCase(
        orderRepository: gh<_i205.OrderRepository>(),
      ),
    );
    gh.lazySingleton<_i364.OrderPlaceUseCase>(
      () =>
          _i364.OrderPlaceUseCase(orderRepository: gh<_i205.OrderRepository>()),
    );
    gh.lazySingleton<_i18.SetQuantityUseCase>(
      () =>
          _i18.SetQuantityUseCase(orderRepository: gh<_i205.OrderRepository>()),
    );
    gh.lazySingleton<_i854.GetAllDeliveryOrdersUseCase>(
      () => _i854.GetAllDeliveryOrdersUseCase(
        deliveryOrdersRepository: gh<_i839.DeliveryOrdersRepository>(),
      ),
    );
    gh.lazySingleton<_i966.GetStaticsUseCase>(
      () => _i966.GetStaticsUseCase(
        deliveryOrdersRepository: gh<_i839.DeliveryOrdersRepository>(),
      ),
    );
    gh.factory<_i858.GlobalLocationCubit>(
      () => _i858.GlobalLocationCubit(
        gh<_i182.GetGovernoratesUseCase>(),
        gh<_i230.GetRegionUseCase>(),
      ),
    );
    gh.factory<_i170.DeliveryActionsCubit>(
      () => _i170.DeliveryActionsCubit(
        gh<_i378.AcceptDeliveryOrderUseCase>(),
        gh<_i90.UpdateDeliveryOrderUseCase>(),
        gh<_i985.SocketService>(),
        gh<_i651.RejectDeliveryOrderUseCase>(),
        gh<_i181.GetOrderDetailsUseCase>(),
      ),
    );
    gh.factory<_i252.TrackOrderCubit>(
      () => _i252.TrackOrderCubit(gh<_i495.GetOrderDetailsUseCase>()),
    );
    gh.factory<_i121.TrackOrderCubit>(
      () => _i121.TrackOrderCubit(
        gh<_i646.GetOrderDetailsUseCase>(),
        gh<_i507.DeleteOrderUseCase>(),
      ),
    );
    gh.lazySingleton<_i77.RejectDeliveryOrderUseCase>(
      () => _i77.RejectDeliveryOrderUseCase(
        repository: gh<_i839.DeliveryOrdersRepository>(),
      ),
    );
    gh.lazySingleton<_i17.UpdateDeliveryOrderUseCase>(
      () => _i17.UpdateDeliveryOrderUseCase(
        repository: gh<_i839.DeliveryOrdersRepository>(),
      ),
    );
    gh.factory<_i511.LocationCubit>(
      () => _i511.LocationCubit(
        gh<_i763.GetGoogleSuggestUseCase>(),
        gh<_i50.GetPlaceDetailsByPlaceIdUseCase>(),
      ),
    );
    gh.factory<_i347.BannersCubit>(
      () => _i347.BannersCubit(
        gh<_i609.GetBannersUseCase>(),
        gh<_i45.GetMainCategoryUseCase>(),
      ),
    );
    gh.factory<_i761.NotificationsCubit>(
      () => _i761.NotificationsCubit(
        gh<_i907.GetNotificationListUseCase>(),
        gh<_i107.MarkAllAsReadUseCase>(),
        gh<_i150.GetNotificationsCount>(),
      ),
    );
    gh.factory<_i761.SupplierDetailsBloc>(
      () => _i761.SupplierDetailsBloc(
        gh<_i548.GetSupplierDetailsCategoryUseCase>(),
      ),
    );
    gh.lazySingleton<_i2.UpdateDeviceToken>(
      () => _i2.UpdateDeviceToken(gh<_i523.MainRepository>()),
    );
    gh.factory<_i106.DeleteAccountUseCase>(
      () => _i106.DeleteAccountUseCase(
        authRepository: gh<_i475.AuthRepository>(),
      ),
    );
    gh.factory<_i1020.LogOutUseCase>(
      () => _i1020.LogOutUseCase(authRepository: gh<_i475.AuthRepository>()),
    );
    gh.factory<_i200.LoginUserUseCase>(
      () => _i200.LoginUserUseCase(authRepository: gh<_i475.AuthRepository>()),
    );
    gh.factory<_i1029.RegisterUserUseCase>(
      () => _i1029.RegisterUserUseCase(
        authRepository: gh<_i475.AuthRepository>(),
      ),
    );
    gh.factory<_i741.ResendOtpUseCase>(
      () => _i741.ResendOtpUseCase(authRepository: gh<_i475.AuthRepository>()),
    );
    gh.factory<_i813.VerifyOtpUseCase>(
      () => _i813.VerifyOtpUseCase(authRepository: gh<_i475.AuthRepository>()),
    );
    gh.lazySingleton<_i753.GetUserDataUseCase>(
      () =>
          _i753.GetUserDataUseCase(authRepository: gh<_i475.AuthRepository>()),
    );
    gh.factory<_i604.TrackOrderCubit>(
      () => _i604.TrackOrderCubit(gh<_i181.GetOrderDetailsUseCase>()),
    );
    gh.factory<_i880.ToggleAvailabilityUseCase>(
      () => _i880.ToggleAvailabilityUseCase(
        mainRepository: gh<_i381.DriverMainRepository>(),
      ),
    );
    gh.factory<_i892.DeliveryMainCubit>(
      () => _i892.DeliveryMainCubit(gh<_i131.UpdateFcmUseCase>()),
    );
    gh.factory<_i212.DriverMainCubit>(
      () => _i212.DriverMainCubit(gh<_i131.UpdateFcmUseCase>()),
    );
    gh.factory<_i288.DeliveryMainCubit>(
      () => _i288.DeliveryMainCubit(gh<_i131.UpdateFcmUseCase>()),
    );
    gh.factory<_i881.OrdersCubit>(
      () => _i881.OrdersCubit(gh<_i55.GetOrderListUseCase>()),
    );
    gh.factory<_i407.DeliveryOrderCubit>(
      () => _i407.DeliveryOrderCubit(
        gh<_i854.GetAllDeliveryOrdersUseCase>(),
        gh<_i985.SocketService>(),
      ),
    );
    gh.factory<_i27.OtpBloc>(
      () => _i27.OtpBloc(
        gh<_i813.VerifyOtpUseCase>(),
        gh<_i620.DeviceHelper>(),
        gh<_i741.ResendOtpUseCase>(),
      ),
    );
    gh.lazySingleton<_i430.OnBoardingCubit>(
      () => _i430.OnBoardingCubit(
        gh<_i1048.GetIntroDataUseCase>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i119.ProfileBloc>(
      () => _i119.ProfileBloc(gh<_i753.GetUserDataUseCase>()),
    );
    gh.factory<_i544.UserBloc>(
      () => _i544.UserBloc(gh<_i753.GetUserDataUseCase>()),
    );
    gh.factory<_i760.MainCubit>(
      () => _i760.MainCubit(gh<_i2.UpdateDeviceToken>()),
    );
    gh.factory<_i347.MessageBloc>(
      () => _i347.MessageBloc(
        gh<_i1027.SendChatUseCase>(),
        gh<_i515.GetChatMessagesUseCase>(),
        gh<_i985.SocketService>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i622.LoginCubit>(
      () => _i622.LoginCubit(gh<_i200.LoginUserUseCase>()),
    );
    gh.lazySingleton<_i96.GetAllDeliveryOrdersUseCase>(
      () => _i96.GetAllDeliveryOrdersUseCase(
        deliveryOrdersRepository: gh<_i765.DeliveryOrdersRepository>(),
      ),
    );
    gh.lazySingleton<_i634.GetStaticsUseCase>(
      () => _i634.GetStaticsUseCase(
        deliveryOrdersRepository: gh<_i765.DeliveryOrdersRepository>(),
      ),
    );
    gh.factory<_i394.DeliveryActionsCubit>(
      () => _i394.DeliveryActionsCubit(
        gh<_i17.UpdateDeliveryOrderUseCase>(),
        gh<_i985.SocketService>(),
        gh<_i495.GetOrderDetailsUseCase>(),
      ),
    );
    gh.factory<_i734.CompleteRegisterBloc>(
      () => _i734.CompleteRegisterBloc(
        gh<_i466.RegisterUserUseCase>(),
        gh<_i577.GetSupplierCategoryUseCase>(),
        gh<_i106.DeleteAccountUseCase>(),
      ),
    );
    gh.factory<_i129.StartCubit>(
      () => _i129.StartCubit(gh<_i598.InitAppUseCase>()),
    );
    gh.factory<_i505.DeleteCubit>(
      () => _i505.DeleteCubit(gh<_i106.DeleteAccountUseCase>()),
    );
    gh.factory<_i1008.LogoutCubit>(
      () => _i1008.LogoutCubit(gh<_i1020.LogOutUseCase>()),
    );
    gh.factory<_i384.CompleteRegisterBloc>(
      () => _i384.CompleteRegisterBloc(
        gh<_i1029.RegisterUserUseCase>(),
        gh<_i106.DeleteAccountUseCase>(),
      ),
    );
    gh.factory<_i462.CartCubit>(
      () => _i462.CartCubit(
        gh<_i326.AddProductToCartUseCase>(),
        gh<_i204.GetCartListUse>(),
        gh<_i1007.DeleteProductToCartUseCase>(),
        gh<_i18.SetQuantityUseCase>(),
        gh<_i364.OrderPlaceUseCase>(),
        gh<_i586.ApplyPromoCodeUseCase>(),
        gh<_i460.SharedPreferences>(),
      ),
    );
    gh.factory<_i1035.MyAddressCubit>(
      () => _i1035.MyAddressCubit(
        gh<_i60.GetAddressUseCase>(),
        gh<_i1036.MakeAddressDefaultUseCase>(),
        gh<_i9.DeleteAddressUseCase>(),
        gh<_i748.GetDeliveryCostUseCase>(),
      ),
    );
    gh.factory<_i44.AvailitiablityCubit>(
      () => _i44.AvailitiablityCubit(gh<_i880.ToggleAvailabilityUseCase>()),
    );
    gh.factory<_i163.DeliveryOrderCubit>(
      () => _i163.DeliveryOrderCubit(
        gh<_i96.GetAllDeliveryOrdersUseCase>(),
        gh<_i985.SocketService>(),
      ),
    );
    gh.factory<_i312.StaticsCubit>(
      () => _i312.StaticsCubit(gh<_i634.GetStaticsUseCase>()),
    );
    gh.factory<_i378.StaticsCubit>(
      () => _i378.StaticsCubit(gh<_i634.GetStaticsUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i379.RegisterModule {}
