import 'package:flutter/material.dart';
import 'package:ps/portfolio/widgets.dart';
import 'package:ps/util/services.dart';

import '../res/res.dart';

class ContactWidget extends StatefulWidget {
  ContactWidget({Key? key}) : super(key: key);

  @override
  State<ContactWidget> createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
    messageController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
  }

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
                child: _NameEmailField(controller: nameController),
              ),
              const SizedBox(width: 16),
              _FieldWidget(
                text: Strings.emailField,
                child: _NameEmailField(controller: emailController),
                required: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SelectableText(
                Strings.messageField,
                style: TextStyles.portfolio.copyWith(fontSize: 12),
              ),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: ThemeColors.textGradients,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: Text('*', style: TextStyles.portfolio, softWrap: true),
              )
            ],
          ),
          const SizedBox(height: 8),
          _MessageField(controller: messageController),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: _SubmitButton(
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

class _MessageField extends StatelessWidget {
  final TextEditingController controller;
  const _MessageField({Key? key, required this.controller}) : super(key: key);

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

class _NameEmailField extends StatelessWidget {
  final TextEditingController controller;
  const _NameEmailField({Key? key, required this.controller}) : super(key: key);

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

class _SubmitButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController messageController;
  const _SubmitButton(
      {Key? key,
      required this.nameController,
      required this.emailController,
      required this.messageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valid = emailController.text != '' && messageController.text != '';
    final color =
        valid ? ThemeColors.textColor : ThemeColors.textColor.withOpacity(0.5);
    return OnHover(
      translate: valid,
      updatePointer: valid,
      builder: (isHovered) {
        return InkWell(
          onTap: valid
              ? () {
                  final success = ContactSubmission.submitForm(
                    name: nameController.text,
                    email: emailController.text,
                    message: messageController.text,
                  );
                  if (!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(Strings.errorSending)));
                  }
                }
              : null,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Strings.sendButton,
                  style:
                      TextStyles.portfolio.copyWith(fontSize: 12, color: color),
                ),
                const SizedBox(width: 16),
                Icon(Icons.send_rounded, size: 16, color: color),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FieldWidget extends StatelessWidget {
  final Widget child;
  final String text;
  final bool required;

  const _FieldWidget({
    Key? key,
    required this.child,
    required this.text,
    this.required = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SelectableText(
                text,
                style: TextStyles.portfolio.copyWith(fontSize: 12),
              ),
              if (required)
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: ThemeColors.textGradients,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
                  child: Text('*', style: TextStyles.portfolio, softWrap: true),
                ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
