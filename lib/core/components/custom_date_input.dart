import 'package:car_pooling/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomDateInput extends StatefulWidget {
  const CustomDateInput({
    super.key,
    required this.dateController,
    this.validator,
    required this.hintText,
    this.title = "",
    this.isEnabled = true,
    this.onChanged,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.dateFormat = 'MM/dd/yyyy',
    this.monthYearOnly = false, // New parameter to control picker mode
    this.monthYearFormat = 'MM/yyyy', // Format for month/year mode
  });

  final TextEditingController dateController;
  final FormFieldValidator<String>? validator;
  final String hintText;
  final String title;
  final bool isEnabled;
  final Function(String)? onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final String dateFormat;
  final bool monthYearOnly; // Whether to show only month/year picker
  final String monthYearFormat; // Format string for month/year display

  @override
  State<CustomDateInput> createState() => _CustomDateInputState();
}

class _CustomDateInputState extends State<CustomDateInput> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _parseInitialDateFromController();
  }

  void _parseInitialDateFromController() {
    if (widget.dateController.text.isNotEmpty) {
      try {
        // Use the appropriate format based on monthYearOnly flag
        String format = widget.monthYearOnly ? widget.monthYearFormat : widget.dateFormat;
        _selectedDate = DateFormat(format).parse(widget.dateController.text);
      } catch (e) {
        // Handle or log parsing error if the initial text doesn't match the format
        debugPrint("Error parsing initial date from controller: $e");
        _selectedDate = null; // Reset if parsing fails
      }
    }
  }

  // New method to handle month/year selection
  Future<void> _selectMonthYear(BuildContext context) async {
    final DateTime now = DateTime.now();
    final initialDate = widget.initialDate ?? _selectedDate ?? now;
    final firstDate = widget.firstDate ?? DateTime(2000);
    final lastDate = widget.lastDate ?? DateTime(2101);

    // Start with year selection
    int? selectedYear = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return _buildYearPicker(
          context, 
          initialDate.year,
          firstDate.year,
          lastDate.year,
        );
      },
    );

    // If user cancels year selection, exit
    if (selectedYear == null) return;

    // Now select month
    int? selectedMonth = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return _buildMonthPicker(context, initialDate.month);
      },
    );

    // If user cancels month selection, exit
    if (selectedMonth == null) return;

    // Create the new date with day set to 1
    final DateTime picked = DateTime(selectedYear, selectedMonth, 1);
    
    setState(() {
      _selectedDate = picked;
      // Format as month/year
      widget.dateController.text = DateFormat(widget.monthYearFormat).format(picked);
      if (widget.onChanged != null) {
        widget.onChanged!(widget.dateController.text);
      }
    });
  }

  // Helper method to build the year picker dialog
  Widget _buildYearPicker(BuildContext context, int initialYear, int firstYear, int lastYear) {
    return AlertDialog(
      title: Text('Select Year'),
      content: Container(
        // Wrap ListView in a Container with fixed height
        width: double.minPositive,
        height: 300.h,
        child: ListView.builder(
          itemCount: lastYear - firstYear + 1,
          itemBuilder: (BuildContext context, int index) {
            final year = firstYear + index;
            return ListTile(
              title: Center(child: Text(year.toString())),
              selected: year == initialYear,
              onTap: () => Navigator.of(context).pop(year),
            );
          },
        ),
      ),
    );
  }

  // Helper method to build the month picker dialog
  Widget _buildMonthPicker(BuildContext context, int initialMonth) {
    final List<String> months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ];

    return AlertDialog(
      title: Text('Select Month'),
      content: SizedBox(
        width: double.minPositive,
        height: 300.h,
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (BuildContext context, int index) {
            // Month index is 0-based in the list but 1-based in DateTime
            final monthIndex = index + 1;
            return ListTile(
              title: Center(child: Text(months[index])),
              selected: monthIndex == initialMonth,
              onTap: () => Navigator.of(context).pop(monthIndex),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              widget.title,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray,
              ),
            ),
          ),
        TextFormField(
          controller: widget.dateController,
          readOnly: true,
          enabled: widget.isEnabled,
          style: GoogleFonts.roboto(
            fontSize: 14.sp,
            color: widget.isEnabled ? AppColors.darkGray : Colors.grey.shade600,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.roboto(
              fontSize: 16.sp,
              color: AppColors.gray,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.lightGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red.shade700),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: !widget.isEnabled,
            fillColor: Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 12.h,
            ),
            suffixIcon: Icon(
              Icons.calendar_today_outlined,
              color: widget.isEnabled ? AppColors.darkGray : Colors.grey,
              size: 20.sp,
            ),
          ),
          validator: widget.validator,
          onTap: widget.isEnabled
              ? () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  // Branch based on monthYearOnly flag
                  if (widget.monthYearOnly) {
                    await _selectMonthYear(context);
                  } else {
                    // Original date picker logic
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: widget.initialDate ?? _selectedDate ?? DateTime.now(),
                      firstDate: widget.firstDate ?? DateTime(2000),
                      lastDate: widget.lastDate ?? DateTime(2101),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: AppColors.primary,
                              onPrimary: Colors.white,
                              onSurface: AppColors.darkGray,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary,
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (picked != null) {
                      setState(() {
                        _selectedDate = picked;
                        widget.dateController.text = DateFormat(widget.dateFormat).format(picked);
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget.dateController.text);
                        }
                      });
                    }
                  }
                }
              : null,
        ),
      ],
    );
  }
}