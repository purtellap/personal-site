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
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyles.portfolio.copyWith(fontSize: 14),
    );
  }
}

class NameEmailField extends StatelessWidget {
  final TextEditingController controller;
  const NameEmailField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      autofocus: false,
      enableSuggestions: false,
      cursorColor: ThemeColors.secondaryTextColor,
      decoration: InputDecoration(
        fillColor: ThemeColors.secondaryBackgroundColor,
        filled: true,
        hoverColor: Colors.transparent,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyles.portfolio.copyWith(fontSize: 14),
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
    return OnHover(
      builder: (isHovered) {
        return InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Strings.sendButton,
                  style: TextStyles.portfolio.copyWith(fontSize: 12),
                ),
                const SizedBox(width: 16),
                Icon(Icons.send_rounded, size: 16),
              ],
            ),
          ),
        );
      },
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
      padding: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: ThemeColors.secondaryBackgroundColor),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            children: [
              _FieldWidget(
                text: Strings.nameField,
                child: NameEmailField(controller: nameController),
              ),
              const SizedBox(width: 16),
              _FieldWidget(
                text: Strings.emailField,
                child: NameEmailField(controller: emailController),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: SelectableText(
              Strings.messageField,
              style: TextStyles.portfolio.copyWith(fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
          MessageField(controller: messageController),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: SubmitButton(
                nameController: nameController,
                emailController: emailController,
                messageController: messageController),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _FieldWidget extends StatelessWidget {
  final Widget child;
  final String text;

  const _FieldWidget({
    Key? key,
    required this.child,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            text,
            style: TextStyles.portfolio.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
