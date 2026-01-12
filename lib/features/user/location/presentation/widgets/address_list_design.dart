import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/location/presentation/widgets/address_item_design.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../captain/delivery_order/data/models/response/my_address.dart';

class AddressListDesign extends StatefulWidget {
  final List<MyAddress> addressList;
  final Function(MyAddress) addressCallback;
  final bool showActions;

  const AddressListDesign({
    super.key,
    required this.addressList,
    required this.addressCallback,
    required this.showActions,
  });

  @override
  State<AddressListDesign> createState() => _AddressListDesignState();
}

class _AddressListDesignState extends State<AddressListDesign> {
  num? _selectedAddress;

  @override
  void initState() {
    if (ApiConfig.myAddress == null) {
      for (var element in widget.addressList) {
        if (element.isDefault == true) {
          _selectedAddress = element.id;
        }
      }
    } else {
      _selectedAddress = ApiConfig.myAddress?.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.addressList.isEmpty) {
      return Expanded(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.bodyHeight * .08),
            AppImage.asset(
              Assets.images.noLocation.path,
              height: SizeConfig.bodyHeight * .3,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            Center(
              child: AppText(
                textSize: 16,
                text: context.localizations.noLocation,
              ),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
          ],
        ),
      );
    } else {
      return Expanded(
        child: ListView.separated(
          padding: EdgeInsets.only(top: SizeConfig.bodyHeight * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () async {
              if (widget.showActions) return;
              setState(() => _selectedAddress = widget.addressList[index].id);
              widget.addressCallback(widget.addressList[index]);
            },
            child: AddressItemDesign(
              callback: () {
                setState(() => _selectedAddress = widget.addressList[index].id);
                widget.addressCallback(widget.addressList[index]);
              },
              showActions: widget.showActions,
              isSelected: _selectedAddress == widget.addressList[index].id,
              address: widget.addressList[index],
            ),
          ),
          separatorBuilder: (context, index) => Container(
            color: context.colorScheme.outline,
            height: 1,
            width: SizeConfig.screenWidth,
          ),
          itemCount: widget.addressList.length,
        ),
      );
    }
  }
}
