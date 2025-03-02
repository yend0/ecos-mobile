import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/router/router.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/generated/generated.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _key = GlobalKey<FormState>();

  late AccountFormState _state;

  late final TextEditingController _birthDateController;
  late final TextEditingController _emailController;
  late final TextEditingController _fullNameController;

  final _birthDateFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();

    _state = AccountFormState();

    final initialEmail = 'remezov@cs.vsu.ru';
    final initialBirthDate =
        DateFormat('dd/MM/yyyy').format(DateTime(2003, 7, 15));
    final initialFullName = 'Ремезов Вадим Николаевич';

    _birthDateController = TextEditingController(text: initialBirthDate)
      ..addListener(_onBirthDateChanged);
    _emailController = TextEditingController(text: initialEmail)
      ..addListener(_onEmailChanged);
    _fullNameController = TextEditingController(text: initialFullName)
      ..addListener(_onFullNameChanged);
  }

  @override
  void dispose() {
    _birthDateController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TitleAppBar(
            text: LocaleKeys.buttons_route_account.tr(),
            onPressed: () => context.go(PAGES.profile.screenPath),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.topCenter,
                    child: AvatarCircle(),
                  ),
                  const SizedBox(height: 14.0),
                  ElevatedButton(
                    onPressed: () => {},
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48.0),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.buttons_action_change_image.tr(),
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleDescription(
                        text: LocaleKeys.title_description_full_name.tr(),
                        textStyle: theme.textTheme.titleSmall!,
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          key: const Key('myForm_fullNameInput'),
                          controller: _fullNameController,
                          validator: (value) =>
                              _state.fullName.validator(value ?? '')?.text(),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TitleDescription(
                        text: LocaleKeys.title_description_email.tr(),
                        textStyle: theme.textTheme.titleSmall!,
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          key: const Key('myForm_emailInput'),
                          controller: _emailController,
                          readOnly: true,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12.0),
                            suffixIcon: Icon(
                              Icons.verified,
                              color: Colors.black,
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 24.0,
                              minHeight: 24.0,
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TitleDescription(
                        text: LocaleKeys.title_description_birth_date.tr(),
                        textStyle: theme.textTheme.titleSmall!,
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          key: const Key('myForm_birthDateInput'),
                          controller: _birthDateController,
                          inputFormatters: [_birthDateFormatter],
                          validator: (value) =>
                              _state.birthDate.validator(value ?? '')?.text(),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'XX/XX/20XX',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onEmailChanged() {
    setState(() {
      _state = _state.copyWith(email: Email.dirty(_emailController.text));
    });
  }

  void _onBirthDateChanged() {
    setState(() {
      _state = _state.copyWith(
        birthDate: BirthDate.dirty(_birthDateController.text),
      );
    });
  }

  void _onFullNameChanged() {
    setState(() {
      _state = _state.copyWith(
        fullName: FullName.dirty(_fullNameController.text),
      );
    });
  }
}

extension on FullNameValidationError {
  String text() {
    switch (this) {
      case FullNameValidationError.invalid:
        return LocaleKeys.validations_full_name_validation_error_invalid.tr();
      case FullNameValidationError.empty:
        return LocaleKeys.validations_full_name_validation_error_empty.tr();
    }
  }
}

extension on BirthDateValidationError {
  String text() {
    switch (this) {
      case BirthDateValidationError.invalid:
        return LocaleKeys.validations_birth_date_validation_error_invalid.tr();
      case BirthDateValidationError.empty:
        return LocaleKeys.validations_birth_date_validation_error_empty.tr();
      case BirthDateValidationError.invalidFormat:
        return LocaleKeys.validations_birth_date_validation_error_invalidFormat
            .tr();
    }
  }
}
