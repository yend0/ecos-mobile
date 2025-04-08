import 'dart:async';

import 'package:ecos/clients/clients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/router/router.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/features/auth/auth.dart';
import 'package:ecos/generated/generated.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _key = GlobalKey<FormState>();

  late AccountFormState _state;
  bool _hasChanges = false;

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

    _birthDateController = TextEditingController()
      ..addListener(_onBirthDateChanged);
    _emailController = TextEditingController()..addListener(_onEmailChanged);
    _fullNameController = TextEditingController()
      ..addListener(_onFullNameChanged);

    _birthDateController.addListener(_checkForChanges);
    _fullNameController.addListener(_checkForChanges);

    BlocProvider.of<AuthBloc>(context).add(const AuthCheckLoginInAppEvent());
    BlocProvider.of<AccountBloc>(context).add(const AccountRequestEvent());
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

    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) async {
        if (state is AccountLoadingSuccessState) {
          _emailController.text = state.user.email;
          _fullNameController.text = state.user.full_name ?? '';
          _birthDateController.text = state.user.birth_date != null
              ? DateFormat('dd/MM/yyyy').format(state.user.birth_date!)
              : '';
        } else if (state is AccountLoadingFailureState) {
          await _refreshToken(context);
        }
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: _hasChanges
                ? GeneralFloatingActionButton(
                    theme: theme,
                    text: 'Применить изменения',
                    onPressed: _onSavePressed,
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountRequestState) {
                  return Scaffold(
                    body: const LoadingCenterProgress(),
                  );
                }
                if (state is AccountLoadingFailureState) {
                  return CustomScrollView(
                    slivers: [
                      TitleAppBar(
                        text: LocaleKeys.buttons_route_account.tr(),
                        onPressed: () => context.go(PAGES.profile.screenPath),
                      ),
                      SliverToBoxAdapter(
                        child: BaseError(
                          onPressed: () async {
                            final accountBloc =
                                BlocProvider.of<AccountBloc>(context);
                            final complete = Completer();

                            accountBloc
                                .add(AccountRequestEvent(completer: complete));
                            await complete.future;
                          },
                        ),
                      ),
                    ],
                  );
                }
                return CustomScrollView(
                  slivers: [
                    TitleAppBar(
                      text: LocaleKeys.buttons_route_account.tr(),
                      onPressed: () => context.go(PAGES.profile.screenPath),
                    ),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        if (state is AccountLoadingSuccessState) {
                          return SliverToBoxAdapter(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16.0),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: AvatarCircle(
                                      imageUrl: state.user.image_url,
                                    ),
                                  ),
                                  const SizedBox(height: 14.0),
                                  ElevatedButton(
                                    onPressed: () => {},
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      elevation: 0.0,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(48.0),
                                      ),
                                    ),
                                    child: Text(
                                      LocaleKeys.buttons_action_change_image
                                          .tr(),
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return SliverToBoxAdapter(
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
                                        borderRadius:
                                            BorderRadius.circular(48.0),
                                      ),
                                    ),
                                    child: Text(
                                      LocaleKeys.buttons_action_change_image
                                          .tr(),
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
                        child: SizedBox(
                          child: Form(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TitleDescription(
                                  text: LocaleKeys.title_description_full_name
                                      .tr(),
                                  textStyle: theme.textTheme.titleSmall!,
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextFormField(
                                    key: const Key('myForm_fullNameInput'),
                                    controller: _fullNameController,
                                    validator: (value) => _state.fullName
                                        .validator(value ?? '')
                                        ?.text(),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextFormField(
                                    key: const Key('myForm_emailInput'),
                                    controller: _emailController,
                                    readOnly: true,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                      suffixIcon:
                                          BlocBuilder<AuthBloc, AuthState>(
                                        builder: (context, state) {
                                          if (state is AuthAuthorizedState) {
                                            if (state.userInfo != null) {
                                              final UserInfo userInfo =
                                                  state.userInfo!;

                                              return userInfo.email_verified
                                                  ? Icon(
                                                      Icons.verified,
                                                      color: Colors.black,
                                                    )
                                                  : Icon(
                                                      Icons.warning,
                                                      color: Colors.black,
                                                    );
                                            }
                                          }
                                          return Icon(
                                            Icons.schedule,
                                            color: Colors.black,
                                          );
                                        },
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
                                  text: LocaleKeys.title_description_birth_date
                                      .tr(),
                                  textStyle: theme.textTheme.titleSmall!,
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextFormField(
                                    key: const Key('myForm_birthDateInput'),
                                    controller: _birthDateController,
                                    inputFormatters: [_birthDateFormatter],
                                    validator: (value) => _state.birthDate
                                        .validator(value ?? '')
                                        ?.text(),
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.datetime,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      hintText: 'MM/dd/yyyy',
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
                );
              },
            ),
          );
        },
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

  void _checkForChanges() {
    final currentState = BlocProvider.of<AccountBloc>(context).state;
    if (currentState is AccountLoadingSuccessState) {
      final hasChanges =
          _fullNameController.text != (currentState.user.full_name ?? '') ||
              _birthDateController.text !=
                  (currentState.user.birth_date != null
                      ? DateFormat('dd/MM/yyyy')
                          .format(currentState.user.birth_date!)
                      : '');

      if (_hasChanges != hasChanges) {
        setState(() {
          _hasChanges = hasChanges;
        });
      }
    }
  }

  void _onSavePressed() {
    if (_key.currentState?.validate() ?? false) {
      final fullName = _fullNameController.text;
      final birthDateString = _birthDateController.text;
      DateTime? birthDate;
      try {
        birthDate = DateFormat('MM/dd/yyyy').parseStrict(birthDateString);
      } catch (_) {
        birthDate = null;
      }

      final accountBloc = BlocProvider.of<AccountBloc>(context);
      final complete = Completer();
      accountBloc.add(
        AccountUpdateEvent(
          completer: complete,
          fullName: fullName,
          birthDate: birthDate,
        ),
      );

      setState(() {
        _hasChanges = false;
      });
    }
  }

  Future<void> _refreshToken(BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final accountBloc = BlocProvider.of<AccountBloc>(context);
    final complete = Completer();

    authBloc.add(AuthRefreshEvent(completer: complete));
    await complete.future;

    accountBloc.add(AccountRequestEvent(completer: complete));

    await complete.future;
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
