import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String url;
  final List<String> image;

  const ImagePreviewScreen({super.key, required this.url, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            wantKeepAlive: true,
            key: const PageStorageKey<String>('photoViewGallery'),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(image[index]),
                heroAttributes: PhotoViewHeroAttributes(tag: image[index]),
              );
            },
            itemCount: image.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                          event.expectedTotalBytes!.toInt(),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SafeArea(
                child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.black.withOpacity(0.4)),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: AppImage.asset(
                Assets.icons.close,
                color: Colors.white,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
