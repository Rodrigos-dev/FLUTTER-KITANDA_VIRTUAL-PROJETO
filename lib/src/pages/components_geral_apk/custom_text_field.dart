import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;  
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;//

  final TextEditingController? controller;

  final TextInputType? textInputType;
  final void Function(String?)? onSaved;//

  final GlobalKey<FormFieldState>? formFieldKey;


  const CustomTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue = '',
    this.readOnly = false,
    this.validator,
    this.controller,
    this.textInputType,
    this.onSaved,
    this.formFieldKey
    }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  
  bool isObscure = false;

  @override
  void initState() {
    // TODO: implement initState
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      
      child: TextFormField(
        controller: widget.controller,
        //initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        inputFormatters: widget.inputFormatters,        
        obscureText: isObscure, 
        validator: widget.validator,//

        keyboardType: widget.textInputType,  
        onSaved: widget.onSaved, 

        key: widget.formFieldKey,

        decoration: InputDecoration(          
          prefixIcon: Icon(widget.icon),         
          suffixIcon: widget.isSecret
          ? IconButton(
            onPressed: () {
              setState(() {                
              isObscure = !isObscure;
              });              
            },
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off)
          ) : null,          
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18)
          ),
        ),
      ),
    );   
  }
}