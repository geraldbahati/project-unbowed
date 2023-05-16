import 'package:flutter/material.dart';
import 'package:unbowed_flutter/presentation/widgets/buttons/icon_button.dart';

import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/textfields/phone_number_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          const Text('Welcome'),
          const Text("Enter your phone number"),
          PhoneTextField(),
          CustomIconButton(),
          CustomElevatedButton(text: "Register"),
        ],
      ),
    );
  }
}
