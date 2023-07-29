import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/auth_screens/login_screen.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:http/http.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  bool hidePass = true;

  void managePassVisibility() {
    setState(() {
      hidePass = !hidePass;
    });
  }

  Future<void> loginSystem(email, pass) async {
    final response = await post(Uri.parse('https://reqres.in/api/register'), body: {
      'email': email,
      'password': pass,
    });
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Register Successfully',
        text: 'Email : $email\nPassword : $pass',
        confirmBtnText: 'Done',
      );
    }
    else {
      // ignore: use_build_context_synchronously
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Check Your Information',
        text: 'Email : $email\nPassword : $pass',
        confirmBtnText: 'Try Again',
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height * 0.07;
    double width = screenSize.width * 0.8;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.3,
              ),
              Container(child: const Text('Register', style: TextStyle(fontSize: 25, color: Colors.black),)),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: height,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.grey,
                  style: const TextStyle(fontSize: 25),
                  decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.alternate_email_outlined, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: height,
                width: width,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: TextField(
                  controller: pass,
                  obscureText: hidePass,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.grey,
                  style: const TextStyle(fontSize: 25),
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      prefixIcon: const Icon(Icons.security, color: Colors.black),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            managePassVisibility();
                          });
                        },
                        child: hidePass == false
                            ? const Icon(Icons.visibility, color: Colors.black)
                            : const Icon(Icons.visibility_off, color: Colors.black),
                      )),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.03,
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {
                    loginSystem(email.text, pass.text);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: height,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogInScreen()));
                  });
                },
                child: const Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(
                              text: 'Want to login your account?',
                              style: TextStyle(
                                color: Colors.black,
                              )
                          ),
                          TextSpan(
                              text: ' Login account!',
                              style: TextStyle(
                                color: Colors.blue,
                              )
                          )
                        ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
