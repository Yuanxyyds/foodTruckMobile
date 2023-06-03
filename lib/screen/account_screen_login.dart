import 'package:flutter/material.dart';
import 'package:food_truck_mobile/helper/auth.dart';
import 'package:food_truck_mobile/icons/google_icon.dart';
import 'package:food_truck_mobile/screen/account_screen_profile.dart';
import 'package:food_truck_mobile/screen/register_screen.dart';
import 'package:food_truck_mobile/widget/clickable_label.dart';
import 'package:food_truck_mobile/widget/input_field.dart';
import 'package:food_truck_mobile/widget/section_header_single_line.dart';
import 'package:food_truck_mobile/widget/text.dart';
import '../helper/constants.dart';
import '../widget/bottom_navigation.dart';
import '../widget/button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreenLogin extends StatefulWidget {
  const AccountScreenLogin({Key? key}) : super(key: key);

  @override
  State<AccountScreenLogin> createState() => _AccountScreenLoginState();
}

class _AccountScreenLoginState extends State<AccountScreenLogin> {
  final TextEditingController _inputEmail = TextEditingController();
  final TextEditingController _inputPassword = TextEditingController();
  bool _emailMode = true;
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TextHeadlineSmall(
            text: 'My Account',
          ),
          actions: [
            Switch(
              value: true,
              onChanged: (bool newValue) {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const AccountScreenProfile(),
                    transitionDuration: Duration.zero,
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _auth.signOut();
          },
          child: Icon(Icons.add),
        ),

        bottomNavigationBar: const BottomNavigation(
          currentIndex: 3,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: ListView(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/UnknownUser.jpg'),
                ),
              ),
              const Center(
                child: TextTitleLarge(
                  text: 'Create an account or log in',
                  isBold: true,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              const Center(
                child: TextTitleMedium(
                  text: 'Log in below or create.',
                  padding: EdgeInsets.zero,
                ),
              ),
              const Center(
                child: TextTitleMedium(
                  text: 'a new Food Truck account.',
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 8),
              Button(
                  text: 'Continue with Facebook',
                  backgroundColor: const Color(0xFF1877F2),
                  textColor: Constants.whiteColor,
                  icon: Icons.facebook,
                  takeLeastSpace: true,
                  onPressed: () {}),
              const SizedBox(height: 8),
              Button(
                text: 'Continue with Google',
                textColor: Constants.whiteColor,
                icon: GoogleIcon.google,
                takeLeastSpace: true,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              Button(
                text: 'Continue with Apple',
                textColor: Constants.whiteColor,
                backgroundColor: Constants.blackColor,
                icon: Icons.apple,
                takeLeastSpace: true,
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              const SectionHeaderSingleLine(
                text: 'or log in using email',
              ),
              const SizedBox(height: 8),
              if (_emailMode)
                InputField(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  controller: _inputEmail,
                ),
              if (!_emailMode)
                InputField(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.password),
                  controller: _inputPassword,
                  obscureText: true,
                ),
              const SizedBox(height: 8),
              if (_emailMode)
                Button(
                  text: 'Next',
                  textColor: Constants.whiteColor,
                  takeLeastSpace: true,
                  onPressed: () {
                    setState(() {
                      if (_inputEmail.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Email Cannot be Empty!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        _emailMode = !_emailMode;
                      }
                    });
                  },
                ),
              if (!_emailMode)
                Button(
                  text: 'Finish',
                  textColor: Constants.whiteColor,
                  takeLeastSpace: true,
                  onPressed: () {
                    setState(() {
                      if (_inputPassword.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Password Cannot be Empty!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        _auth.signInWithEmailAndPassword(
                            email: _inputEmail.text,
                            password: _inputPassword.text);
                        if (_auth.currentUser != null) {
                          Fluttertoast.showToast(
                              msg: "Login Successed!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                          _inputEmail.clear();
                          _inputPassword.clear();
                          _emailMode = !_emailMode;
                        } else {
                          Fluttertoast.showToast(
                              msg: "Invalid Password/Account!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                          _inputEmail.clear();
                          _inputPassword.clear();
                          _emailMode = !_emailMode;
                        }
                      }
                    });
                  },
                ),
              const SizedBox(height: 8),
              if (_emailMode)
                Center(
                    child: ClickableLabel(
                  text: 'Register a new account with email',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
                  },
                )),
              if (!_emailMode)
                const Center(
                    child: ClickableLabel(
                  text: 'Forgot your password?',
                )),
            ],
          ),
        ));
  }
}
