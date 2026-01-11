import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/sliver_padding.dart';
import 'package:taxito/features/captain/auth/data/models/response/user_model_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../../../../core/utils/app_size.dart';
import '../../../../../../../../widgets/app_text.dart';
import '../../../../../../../../widgets/loading/loading_widget.dart';
import '../../../../../data/models/response/user_model.dart';
import '../../../id_photo_picker.dart';
import 'complete_register3_button.dart';
import 'vehicle_image/images_list_design.dart';

class CompleteRegisterPage3 extends StatefulWidget {
  final bool isUpdate;
  const CompleteRegisterPage3({super.key, required this.isUpdate,});

  @override
  State<CompleteRegisterPage3> createState() => _CompleteRegisterPage3State();
}

class _CompleteRegisterPage3State extends State<CompleteRegisterPage3> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> carImages = [];
  List<String> networkCarImages = [];
  bool isLoading = false;

  @override
  void initState() {
    _setUpCarImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            30.verticalSpace.toSliver,
            AppText(
              text: context.localizations.vehicleInfo,
              fontWeight: FontWeight.bold,
              textSize: 18,
            ).toSliverPadding(),
            10.verticalSpace.toSliver,
            Container(
              width: double.infinity,
              height: 1,
              color: context.colorScheme.shadow.withValues(alpha: 0.4),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            AppText(
              text: context.localizations.vehicleImage,
              fontWeight: FontWeight.bold,
              textSize: 14,
            ).toSliverPadding(),
            8.verticalSpace.toSliver,
            AppText(
              text: context.localizations.vehicleImageHint,
              textSize: 14,
            ).toSliverPadding(),
            15.verticalSpace.toSliver,
            if (isLoading)
              const LoadingWidget().toSliverPadding()
            else
              VehicleImagePickerWidget(
                images: (List<String> image) =>
                    setState(() => carImages = image),
                imagesListFromApi: networkCarImages,
              ).toSliverPadding(),
            20.verticalSpace.toSliver,
            IdPhotoPicker(
              name: "frontInsurancePhoto",
              height: SizeConfig.bodyHeight * .25,
              initialImage: UserDataService().getUserData()?.carInsuranceFrontImage,
              title: context.localizations.frontInsurancePhoto,
              validator: FormBuilderValidators.required(errorText: context.localizations.validation),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            IdPhotoPicker(
              name: "backInsurancePhoto",
              height: SizeConfig.bodyHeight * .25,
              initialImage: UserDataService().getUserData()?.carInsuranceFrontImage,
              title: context.localizations.backInsurancePhoto,
              validator: FormBuilderValidators.required(
                  errorText: context.localizations.validation),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            CompleteRegister3Button(
              formKey: _formKey,
              isUpdate: widget.isUpdate,
              carImages: carImages,
            ).toSliverPadding(),
            if (widget.isUpdate) 100.verticalSpace.toSliver,
          ],
        ),
      ),
    );
  }

  void _setUpCarImages() {
    if (UserDataService().getUserData()?.cars != null &&
        UserDataService().getUserData()!.cars!.isNotEmpty) {
      setState(() => isLoading = true);
      for (var element in UserDataService().getUserData()!.cars!) {
        networkCarImages.add(element.url ?? "");
      }
      setState(() => isLoading = false);
    }
  }
}
