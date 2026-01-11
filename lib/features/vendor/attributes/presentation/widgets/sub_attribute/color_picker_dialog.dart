import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorPickerDialog extends StatefulWidget {
  final String? currentColor;
  final Function(String) onColorSelected;

  const ColorPickerDialog({
    super.key,
    this.currentColor,
    required this.onColorSelected,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  String? _selectedColor;

  final List<Map<String, dynamic>> _colors = [
    {'name': 'أحمر', 'value': '#FF0000'},
    {'name': 'أزرق', 'value': '#0000FF'},
    {'name': 'أخضر', 'value': '#00FF00'},
    {'name': 'أصفر', 'value': '#FFFF00'},
    {'name': 'برتقالي', 'value': '#FFA500'},
    {'name': 'بنفسجي', 'value': '#800080'},
    {'name': 'وردي', 'value': '#FFC0CB'},
    {'name': 'بني', 'value': '#A52A2A'},
    {'name': 'رمادي', 'value': '#808080'},
    {'name': 'أسود', 'value': '#000000'},
    {'name': 'أبيض', 'value': '#FFFFFF'},
    {'name': 'ذهبي', 'value': '#FFD700'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.localizations.chooseColor),
      content: SizedBox(
        width: 300.w,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _colors.length,
          itemBuilder: (context, index) {
            final color = _colors[index];
            final isSelected = _selectedColor == color['value'];
            
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color['value'];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(color['value'].replaceFirst('#', '0xff'))),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Colors.black : Colors.grey,
                    width: isSelected ? 3 : 1,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localizations.cancel),
        ),
        TextButton(
          onPressed: () {
            if (_selectedColor != null) {
              widget.onColorSelected(_selectedColor!);
              Navigator.of(context).pop();
            }
          },
          child: Text(context.localizations.confirm),
        ),
      ],
    );
  }
}
