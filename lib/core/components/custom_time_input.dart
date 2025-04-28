import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:car_pooling/core/constant/app_style.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTimeInput extends StatefulWidget {
  const CustomTimeInput({
    super.key,
    required this.time,
    required this.onChange,
    required this.isEnabled,
    this.hintText,
  });
  final bool isEnabled;
  final String? hintText;
  final Time? time;
  final Function(Time) onChange;

  @override
  State<CustomTimeInput> createState() => _CustomTimeInputState();
}

class _CustomTimeInputState extends State<CustomTimeInput> {
  Time? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!widget.isEnabled) return;
        Navigator.of(context).push(
          showPicker(
            context: context,
            value: selectedTime ?? Time(hour: 0, minute: 0),
            sunrise: TimeOfDay(hour: 6, minute: 0), // optional
            sunset: TimeOfDay(hour: 18, minute: 0), // optional
            duskSpanInMinutes: 120, // optional
            onChange: (newTime) {
              setState(() {
                selectedTime = newTime;
              });
              widget.onChange(newTime);
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          selectedTime != null
              ? "${selectedTime!.hour}:${selectedTime!.minute}"
              : widget.hintText ?? "",
          style: AppStyle.baseRegular,
        ),
      ),
    );
  }
}
