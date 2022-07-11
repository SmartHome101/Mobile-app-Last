import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../shared/Custom_Widgets.dart';
import '../Controllers/authentication_servies.dart';

class Reset_Password extends StatefulWidget {
  const Reset_Password({Key? key}) : super(key: key);

  @override
  State<Reset_Password> createState() => _Reset_PasswordState();
}

class _Reset_PasswordState extends State<Reset_Password> {
  String email = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            decoration: Background_decoration(),
            height: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 100.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    hintText: "Email",
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    isPassword: false,
                    icon: Icons.email,
                    InputType: inputType.Email,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomeButton(
                    title: "Reset",
                    onTap: () async {
                      isLoading = true;
                      setState(() {});

                      var result = await context
                          .read<AuthenticationService>()
                          .resetPassword(email: email);
                      if (result == "success") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Please Check your email for the reset link")));
                      } else if (result == "error") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Something Went Wrong please Try again")));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                      }
                      isLoading = false;
                      setState(() {});
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
