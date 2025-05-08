import 'dart:async';

import 'package:ecos/clients/clients.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/router/router.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/features/auth/auth.dart';
import 'package:ecos/generated/generated.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _key = GlobalKey<FormState>();

  late AccountFormState _state;
  bool _hasChanges = false;

  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    _state = AccountFormState();

    _emailController = TextEditingController()..addListener(_onEmailChanged);

    _emailController.text = widget.user.email;

    BlocProvider.of<AuthBloc>(context).add(const AuthCheckLoginInAppEvent());
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountRequestState) {
            return FloatingActionButton(
              onPressed: null,
              backgroundColor: const Color(0xFF25884F),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (_hasChanges && state is AccountInitialState) {
            return GeneralFloatingActionButton(
              theme: theme,
              text: LocaleKeys.buttons_action_change_account_information.tr(),
              onPressed: _onSavePressed,
            );
          } else if (state is AccountLoadingFailureState) {
            return showSnackBar(
              context: context,
              message: LocaleKeys.account_change_failure_snack_bar.tr(),
              color: Colors.red,
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    child: AvatarCircle(
                      imageUrl: widget.user.imageUrl,
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
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0),
              child: SizedBox(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            suffixIcon: widget.user.emailVerified!
                                ? Icon(
                                    Icons.verified,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.warning,
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

  Future<void> _onSavePressed() async {
    if (_key.currentState?.validate() ?? false) {
      final accountBloc = BlocProvider.of<AccountBloc>(context);
      final profileBloc = BlocProvider.of<ProfileBloc>(context);

      setState(() {
        _hasChanges = false;
      });

      final updateCompleter = Completer();
      // accountBloc.add(
      //   AccountUpdateEvent(
      //     completer: updateCompleter,
      //   ),
      // );
      await updateCompleter.future;

      final profileCompleter = Completer();
      profileBloc.add(
        ProfileRequestEvent(
          completer: profileCompleter,
        ),
      );
      await profileCompleter.future;

      showSnackBar(
        context: context,
        message: LocaleKeys.account_change_success_snack_bar.tr(),
        color: Colors.green,
      );

      context.go(PAGES.profile.screenPath);
    }
  }

  showSnackBar({
    required BuildContext context,
    required message,
    required color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
  }
}
