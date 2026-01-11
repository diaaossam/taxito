import 'package:flutter/material.dart';
import 'package:taxito/features/captain/app/data/models/generic_model.dart';

import '../core/extensions/color_extensions.dart';
import 'app_text.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String label;
  final List<GenericModel> items;
  final List<GenericModel>? initialSelectedItems;
  final FormFieldValidator<List<GenericModel>>? validator;
  final ValueChanged<List<GenericModel>>? onChanged;

  const MultiSelectDropdown({
    super.key,
    required this.label,
    required this.items,
    this.initialSelectedItems,
    this.validator,
    this.onChanged,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<GenericModel> selectedItems;

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.initialSelectedItems ?? []);
  }

  void _showMultiSelectDialog() async {
    final List<GenericModel> tempSelected = List.from(selectedItems);

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: widget.label,
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      children: widget.items.map((item) {
                        final isSelected = tempSelected.contains(item);
                        return CheckboxListTile(
                          title: AppText(text: item.title ?? "-"),
                          value: isSelected,
                          activeColor: context.colorScheme.primary,
                          onChanged: (val) {
                            setModalState(() {
                              if (val == true) {
                                tempSelected.add(item);
                              } else {
                                tempSelected.remove(item);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedItems = List.from(tempSelected);
                      });
                      widget.onChanged?.call(selectedItems);
                      Navigator.pop(context);
                    },
                    child: const AppText(text: "تأكيد", color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayText = selectedItems.isEmpty
        ? widget.label
        : selectedItems.map((e) => e.title).join(", ");
    final error = widget.validator?.call(selectedItems);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: widget.label,
          textSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showMultiSelectDialog,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: error != null && error.isNotEmpty
                    ? Colors.red
                    : const Color(0xFFE5E8F4),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: selectedItems.isEmpty
                      ? AppText.hint(
                          text: displayText,
                          hintColor: Theme.of(context).hintColor,
                          maxLines: 1,
                        )
                      : AppText(
                          text: displayText,
                          color: Colors.black,
                          maxLines: 1,
                        ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(context).hintColor,
                ),
              ],
            ),
          ),
        ),
        if (error != null && error.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 8),
            child: AppText(
              text: error,
              color: Colors.red,
              textSize: 12,
              maxLines: 2,
            ),
          ),
      ],
    );
  }
}
