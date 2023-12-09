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
    nameController.addListener(() => mounted ? setState(() {}) : null);
    emailController.addListener(() => mounted ? setState(() {}) : null);
    messageController.addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
  }

  List<Widget> _buildFreelanceSection() {
    if (context.isMobileWidth) {
      return [
        _FreelanceCategory(name: Strings.frontendDevelopment),
        const SizedBox(height: 12),
        _FreelanceCategory(name: Strings.uiuxDesign),
        const SizedBox(height: 12),
        _FreelanceCategory(name: Strings.webDevelopment),
        const SizedBox(height: 12),
        _FreelanceCategory(name: Strings.technicalConsulting)
      ];
    } else {
      return [
        Row(
          children: [
            Expanded(
                child: _FreelanceCategory(name: Strings.frontendDevelopment)),
            const SizedBox(width: 12),
            Expanded(child: _FreelanceCategory(name: Strings.uiuxDesign))
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _FreelanceCategory(name: Strings.webDevelopment)),
            const SizedBox(width: 12),
            Expanded(
                child: _FreelanceCategory(name: Strings.technicalConsulting))
          ],
        ),
      ];
    }
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
          _FreelanceHeader(),
          const SizedBox(height: 24),
          ..._buildFreelanceSection(),
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
      cursorColor: ThemeColors.textGradients.first,
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
      cursorColor: ThemeColors.textGradients.first,
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
              ? () async {
                  try {
                    final contactSubmission = ContactSubmission();
                    final onCooldown = await contactSubmission.isOnCooldown();

                    String text = Strings.waitSending;
                    if (!onCooldown) {
                      contactSubmission.saveSubmissionTime();
                      final success = await contactSubmission.submitForm(
                        name: nameController.text == ''
                            ? emailController.text
                            : nameController.text,
                        email: emailController.text,
                        message: messageController.text,
                      );
                      if (success) {
                        nameController.clear();
                        emailController.clear();
                        messageController.clear();
                        text = Strings.successSending;
                      } else {
                        text = Strings.errorSending;
                      }
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      width: Dimens.maxPortfolioWidth - 32,
                      content: Center(
                        child: Text(
                          text,
                          style: TextStyles.portfolio2.copyWith(fontSize: 12),
                        ),
                      ),
                      backgroundColor: ThemeColors.secondaryBackgroundColor,
                      padding: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ));
                  } catch (e) {
                    print(e);
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

class _FreelanceHeader extends StatelessWidget {
  const _FreelanceHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(Strings.freelanceOpportunities,
                style: TextStyles.portfolio2.copyWith(fontSize: 16))),
        SizedBox(width: 16),
        Text(Strings.status,
            style: TextStyles.portfolio2.copyWith(fontSize: 12)),
        SizedBox(width: 16),
        _StatusButton(isOpen: true),
      ],
    );
  }
}

class _FreelanceCategory extends StatelessWidget {
  final String name;
  const _FreelanceCategory({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: ThemeColors.freelanceGradients,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          // This row keeps text gradient bounds from expanding to width of parent container
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: ThemeColors.textGradients,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(name,
                  style: TextStyles.portfolio.copyWith(fontSize: 16),
                  softWrap: true),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}

class _StatusButton extends StatelessWidget {
  final bool isOpen;
  const _StatusButton({Key? key, required this.isOpen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: ThemeColors.openGradients,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          isOpen ? Strings.statusOpen : Strings.statusClosed,
          style: TextStyles.portfolio.copyWith(
              color: ThemeColors.textColor.withOpacity(0.8),
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.w100),
        ),
      ),
    );
  }
}
