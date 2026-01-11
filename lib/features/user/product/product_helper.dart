import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/order/data/models/cart_model.dart';
import 'package:aslol/features/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:aslol/features/product/data/models/attributes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

import 'presentation/widgets/note_product_dialog.dart';

class ProductHelper {
  void generateProductLink({String? productId, bool isQr = false}) async {
    final String url = "https://aslolstore.com/product/$productId";
    SharePlus.instance.share(ShareParams(uri: Uri.parse(url)));
  }

  Future<String?> showNoteProduct({required BuildContext context}) async {
    return await showCupertinoModalBottomSheet(
        context: context, builder: (context) => const NoteProductDialog());
  }

  formatUniqueId({required num productId, required List<Values> listOfValues}) {
    String id = productId.toString();
    for (var element in listOfValues) {
      id = "$id${element.attributeValueId.toString()}";
    }
    return id;
  }

  Future<bool> showSupplierWarningDialog(BuildContext context,
      {required String currentSupplierName,
      required String newSupplierName,
      required CartItem newItem}) async {
   return await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          context.localizations.differentSupplier,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        content: Text(
          context.localizations.differentSupplierMessage(
            currentSupplierName,
            newSupplierName,
          ),
          style: TextStyle(fontSize: 12.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              context.localizations.cancel,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CartCubit>().clearCartAndAddNewItem(newItem);
              Navigator.pop(dialogContext,true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
            ),
            child: Text(
              context.localizations.clearCartAndAdd,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
