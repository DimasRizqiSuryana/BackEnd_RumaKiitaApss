import 'package:flutter/material.dart';

import '../../utils/helpers.dart';
import '../../utils/themes.dart';

/// BaseDatePicker
///
/// Pre-configured DatePicker widget
class BaseDatePicker extends StatefulWidget {
  final DateTime? initialDatetime;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime?>? onChanged;
  final bool _enabled;
  final String? label;
  final double? labelFontSize;
  final Color? labelColor;

  const BaseDatePicker({
    super.key,
    this.initialDatetime,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.label,
    bool enabled = true,
    this.labelFontSize,
    this.labelColor,
  }) : _enabled = enabled;

  @override
  State<BaseDatePicker> createState() => _BaseDatePickerState();
}

class _BaseDatePickerState extends State<BaseDatePicker>
    with AutomaticKeepAliveClientMixin {
  DateTime? _datetime;

  @override
  void initState() {
    super.initState();

    if (widget.initialDatetime != null) {
      _datetime = widget.initialDatetime;
    }
  }

  String _datetimeString() {
    if (_datetime != null) {
      return formatedDateTime(_datetime!);
    }

    return 'No Date Selected';
  }

  Widget _labelWidget() {
    if (widget.label == null) {
      return const SizedBox.shrink();
    }

    late double height = 8.0;

    return Column(
      children: [
        Text(
          widget.label!,
          style: TextStyle(
            fontSize: widget.labelFontSize ?? fParagraph,
            color: widget.labelColor ?? cBlack,
            fontWeight: fBold,
          ),
        ),
        SizedBox(height: height),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _datetimeString(),
                  style: const TextStyle(
                    fontSize: fParagraph,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              IconButton(
                onPressed: !widget._enabled
                    ? null
                    : () async {
                        final res = await showDateAndTimePicker(
                          context: context,
                          initialDate: widget.initialDatetime ?? DateTime.now(),
                          firstDate: widget.firstDate,
                          lastDate: widget.lastDate,
                        );

                        if (res != null) {
                          setState(() {
                            _datetime = res;
                          });

                          widget.onChanged?.call(_datetime);
                        }
                      },
                icon: const Icon(Icons.calendar_month),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
