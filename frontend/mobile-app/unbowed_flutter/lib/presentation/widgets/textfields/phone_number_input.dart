import 'package:flutter/material.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          hintText: "Phone Number",
          prefixText: "+254 | ",
          prefixIcon: Icon(Icons.phone),
          prefixIconColor: Colors.black,
        ),
        keyboardType: TextInputType.phone,
      ),
    );
  }
}
