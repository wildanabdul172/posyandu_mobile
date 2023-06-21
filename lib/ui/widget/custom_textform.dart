import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:intl/intl.dart';

class CustomTextForm extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final TextEditingController? controller;

  const CustomTextForm(
      {super.key,
      required this.obsecureText,
      required this.title,
      required this.icon,
      required this.validator,
      required this.onSaved,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: TextFormField(
        obscureText: obsecureText,
        style: blackTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        cursorColor: kBlackColor,
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
            borderRadius: BorderRadius.circular(
              20,
            ),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}

class CustomTextFormDate extends StatefulWidget {
  final String title;
  final IconData icon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const CustomTextFormDate({
    Key? key,
    required this.title,
    required this.icon,
    required this.validator,
    required this.onSaved,
  }) : super(key: key);

  @override
  _CustomTextFormDateState createState() => _CustomTextFormDateState();
}

class _CustomTextFormDateState extends State<CustomTextFormDate> {
  DateTime? _selectedDate;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text =
        _selectedDate != null ? _selectedDate.toString() : '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: _textEditingController,
            cursorColor: kBlackColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              filled: true,
              fillColor: kGreyColor,
              hintText: widget.title,
              hintStyle: blackTextStyle.copyWith(
                fontSize: 12,
                fontWeight: regular,
              ),
              prefixIcon: Icon(
                widget.icon,
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
            validator: widget.validator,
            onSaved: widget.onSaved,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        _textEditingController.text = formatter.format(_selectedDate!);
      });
    }
  }
}

class CustomTextFormDropDown extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final List<String> dropdownValues;

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
        items: dropdownValues.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
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
