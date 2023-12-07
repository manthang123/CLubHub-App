import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../utils/ui_constant.dart';
import 'createaccount_vm.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateAccountScreenViewModel>.reactive(
      viewModelBuilder: () => CreateAccountScreenViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(context),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: UiConstants.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 70),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: UiConstants.titleColor,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Login and start your clubs journey',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: UiConstants.subTitleColor,
                  ),
                ),
                const Spacer(),
                Center(
                  child: SizedBox(
                    width: 360,
                    height: 360,
                    child: Image.asset('assets/clubs_onboard.jpg'),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Platform to get easy access of VIIT college clubs and their club events',
                  style: TextStyle(
                    fontSize: 15,
                    color: UiConstants.describeColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.signInWithGoogle(context: context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(UiConstants.bgButton),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(89.0),
                          side: const BorderSide(
                            color: UiConstants.bgButton,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                    child: viewModel.loading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: UiConstants.mainColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 15),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child:
                                    Image.asset('assets/icons/ic_google.png'),
                              ),
                              const Spacer(),
                              const Text(
                                'Connect with Google',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    'By continuing you agree to our T&C and Privacy Policy',
                    style: TextStyle(
                      fontSize: 10,
                      color: UiConstants.describeColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
