import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ps/portfolio/widgets.dart';

import '../res/res.dart';

class MessageField extends StatelessWidget {
  final TextEditingController controller;
  const MessageField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 6,
      keyboardType: TextInputType.multiline,
      maxLines: 6,
      autocorrect: false,
      autofocus: false,
      enableSuggestions: false,
      cursorColor: ThemeColors.secondaryTextColor,
      decoration: InputDecoration(
        fillColor: ThemeColors.secondaryBackgroundColor,
        filled: true,
        hoverColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyles.portfolio.copyWith(fontSize: 14),
    );
  }
}

class NameEmailField extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets padding;
  const NameEmailField(
      {Key? key, required this.controller, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: padding,
        child: TextField(
          controller: controller,
          autocorrect: false,
          autofocus: false,
          enableSuggestions: false,
          cursorColor: ThemeColors.secondaryTextColor,
          decoration: InputDecoration(
            fillColor: ThemeColors.secondaryBackgroundColor,
            filled: true,
            hoverColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyles.portfolio.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  const SubmitButton(
      {Key? key,
      required this.nameController,
      required this.emailController,
      required this.messageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: OnHover(builder: (isHovered) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Submit',
            style: TextStyles.portfolio.copyWith(fontSize: 14),
          ),
        );
      }),
    );
  }
}

Future sendEmail(
    {required String name,
    required String email,
    required String message}) async {
  const serviceId = 'service_b8guw1a';
  const templateId = 'template_iu8qj8h';
  const userId = 'user_opMB4DYe8DAc4zLXXWcyp';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(url,
      headers: {
        // 'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_message': message,
          'to_email': 'Strings.contactEmail',
        }
      }));
}

class ContactWidget extends StatelessWidget {
  ContactWidget({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ThemeColors.secondaryBackgroundColor),
      child: Column(
        children: [
          Row(
            children: [
              NameEmailField(
                  controller: nameController,
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0)),
              NameEmailField(
                  controller: emailController,
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0))
            ],
          ),
          MessageField(controller: messageController),
          SubmitButton(
              nameController: nameController,
              emailController: emailController,
              messageController: messageController),
        ],
      ),
    );
  }
}
