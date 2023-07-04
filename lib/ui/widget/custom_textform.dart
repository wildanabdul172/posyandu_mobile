import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:intl/intl.dart';

class CustomTextForm extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final TextEditingController? controller;

  const CustomTextForm({
    Key? key,
    required this.obsecureText,
    required this.title,
    required this.icon,
    required this.validator,
    required this.onSaved,
    this.controller,
  }) : super(key: key);

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        obscureText: widget.obsecureText && _obscureText,
        style: blackTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        cursorColor: kBlackColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          filled: true,
          fillColor: kGreyColor,
          hintText: widget.title,
          hintStyle: blackTextStyle.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          prefixIcon: Icon(
            widget.icon,
            color: kBlueColor,
          ),
          suffixIcon: buildSuffixIcon(), // Panggil metode buildSuffixIcon()
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        controller: widget.controller,
        validator: widget.validator,
        onSaved: widget.onSaved,
      ),
    );
  }

  Widget? buildSuffixIcon() {
    if (widget.obsecureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: kBlueColor,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else {
      return null;
    }
  }
}

class CustomTextFormDate extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController controller;

  const CustomTextFormDate({
    Key? key,
    required this.title,
    required this.icon,
    required this.validator,
    required this.onSaved,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true, // Tidak dapat diedit oleh pengguna secara manual
        cursorColor: kBlackColor,
        onTap: () {
          _selectDate(context);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          filled: true,
          fillColor: kGreyColor,
          hintText: title,
          hintStyle: blackTextStyle.copyWith(
            fontSize: 12,
            fontWeight: regular,
          ),
          prefixIcon: Icon(
            icon,
            color: kBlueColor,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        validator: validator,
        onSaved: (value) => onSaved?.call(value),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formattedDate = formatter.format(pickedDate);
      controller.text = formattedDate;
    }
  }
}

class CustomTextFormDropDown extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final List<String?> dropdownValues;

  const CustomTextFormDropDown({
    Key? key,
    required this.title,
    required this.icon,
    required this.validator,
    required this.onSaved,
    required this.dropdownValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: DropdownButtonFormField<String>(
        value: dropdownValues.isNotEmpty ? dropdownValues[0] : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          filled: true,
          fillColor: kGreyColor,
          hintText: title,
          hintStyle: blackTextStyle.copyWith(
            fontSize: 12,
            fontWeight: regular,
          ),
          prefixIcon: Icon(
            icon,
            color: kBlueColor,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
        items: dropdownValues.map((String? value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value!,
              style: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {},
      ),
    );
  }
}
