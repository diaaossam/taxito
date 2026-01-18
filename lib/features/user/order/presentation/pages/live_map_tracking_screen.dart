import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/features/common/models/orders.dart';
import 'package:taxito/features/user/order/presentation/bloc/live_map_tracking/live_map_tracking_cubit.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_app_bar.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';

/// صفحة الخريطة المباشرة - تعرض موقع السائق بشكل مباشر
class LiveMapTrackingScreen extends StatefulWidget {
  final Orders order;

  const LiveMapTrackingScreen({
    super.key,
    required this.order,
  });

  @override
  State<LiveMapTrackingScreen> createState() => _LiveMapTrackingScreenState();
}

class _LiveMapTrackingScreenState extends State<LiveMapTrackingScreen> {
  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _destinationIcon;
  bool _iconsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
  }

  /// تحميل أيقونات الماركر المخصصة
  Future<void> _loadCustomMarkers() async {
    try {
      _driverIcon = await _createMarkerIconFromAsset(
        Assets.images.carTop.path,
        width: 120,
        height: 120,
      );
      
      _destinationIcon = await _createMarkerIconFromAsset(
        Assets.images.destination.path,
        width: 120,
        height: 120,
      );
      
      setState(() {
        _iconsLoaded = true;
      });
    } catch (e) {
      debugPrint('Error loading marker icons: $e');
      // استخدام الأيقونات الافتراضية
      _driverIcon = BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueAzure,
      );
      _destinationIcon = BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      );
      setState(() {
        _iconsLoaded = true;
      });
    }
  }

  /// إنشاء أيقونة مخصصة من الملف
  Future<BitmapDescriptor> _createMarkerIconFromAsset(
    String assetPath, {
    required int width,
    required int height,
  }) async {
    final ByteData data = await rootBundle.load(assetPath);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LiveMapTrackingCubit>()
        ..startTracking(order: widget.order),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.trackOrder,
        ),
        body: BlocConsumer<LiveMapTrackingCubit, LiveMapTrackingState>(
          listener: (context, state) {
            // يمكن إضافة استماع للحالات إذا لزم الأمر
          },
          builder: (context, state) {
            final cubit = context.read<LiveMapTrackingCubit>();
            
            // الموقع الابتدائي للكاميرا
            final LatLng initialPosition = cubit.driverLocation ??
                cubit.destinationLocation ??
                const LatLng(33.3152, 44.3661); // بغداد - افتراضي

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: initialPosition,
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    cubit.setMapController(controller);
                  },
                  markers: _buildMarkers(cubit),
                  polylines: cubit.polylines,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: true,
                  trafficEnabled: false,
                  buildingsEnabled: true,
                  indoorViewEnabled: false,
                  mapType: MapType.normal,
                  minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
                ),
                if (cubit.driverLocation != null)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: _buildDriverInfoCard(context, cubit),
                  ),

              ],
            );
          },
        ),
      ),
    );
  }

  /// بناء الماركرات على الخريطة
  Set<Marker> _buildMarkers(LiveMapTrackingCubit cubit) {
    final Set<Marker> markers = {};

    // ماركر السائق
    if (cubit.driverLocation != null && _iconsLoaded) {
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: cubit.currentAnimatedLocation ?? cubit.driverLocation!,
          icon: _driverIcon ?? BitmapDescriptor.defaultMarker,
          anchor: const Offset(0.5, 0.5),
          rotation: cubit.currentRotation,
          infoWindow: const InfoWindow(
            title: '🚗 السائق',
            snippet: 'في الطريق إليك',
          ),
          zIndex: 2,
        ),
      );
    }

    // ماركر الوجهة
    if (cubit.destinationLocation != null && _iconsLoaded) {
      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: cubit.destinationLocation!,
          icon: _destinationIcon ?? BitmapDescriptor.defaultMarker,
          anchor: const Offset(0.5, 1.0),
          infoWindow: InfoWindow(
            title: '📍 موقع التوصيل',
            snippet: cubit.currentOrder?.address?.address ?? 'عنوانك',
          ),
          zIndex: 1,
        ),
      );
    }

    return markers;
  }

  Widget _buildDriverInfoCard(BuildContext context, LiveMapTrackingCubit cubit) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              context.colorScheme.primary.withOpacity(0.1),
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // صورة السائق
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: context.colorScheme.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            
            // معلومات السائق
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const AppText(
                        text: 'السائق في الطريق',
                        fontWeight: FontWeight.bold,
                        textSize: 15,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 8,
                            ),
                            SizedBox(width: 4),
                            AppText(
                              text: 'مباشر',
                              textSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  AppText(
                    text: 'طلب #${cubit.currentOrder?.id ?? ""}',
                    textSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
            
            // زر الاتصال
            IconButton(
              onPressed: () {
                // TODO: تنفيذ الاتصال بالسائق
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
