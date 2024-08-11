// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:receive_the_product/Getx/auth_controller.dart';
//
// class LoginPage extends StatelessWidget {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final authController = Get.find<AuthController>();
//                 authController.login(
//                   emailController.text,
//                   passwordController.text,
//                 );
//               },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receive_the_product/Getx/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  bool _showPassword = false;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      // نمایش پیام پردازش
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: const Text('Processing Data'),
      //   backgroundColor: Colors.green.shade300,
      // ));
      final authController = Get.find<AuthController>();
                authController.login(
                  emailController.text,
                  passwordController.text,
                );
      // عملیات لاگین
      // bool success = await authController.login(
      //   emailController.text,
      //   passwordController.text,
      // );

      // مخفی کردن پیام پردازش
     // ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // if (success) {
      //   // نمایش پیام موفقیت
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: const Text('Login successful!'),
      //     backgroundColor: Colors.green,
      //   ));
      // } else {
      //   // نمایش پیام خطا
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     content: const Text('Login failed. Please try again.'),
      //     backgroundColor: Colors.red,
      //   ));
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: Form(
          key: _formKey,
          child: Stack(children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Center(
                            child: Text(
                              "ورود به دریافت کالا",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "ایمیل",
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ایمیل خود را وارد کنید';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height * 0.03),
                          TextFormField(
                            obscureText: !_showPassword,
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() =>
                                  _showPassword = !_showPassword);
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: "پسورد",
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'پسورد خود را وارد کنید';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: size.height * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: login,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15)),
                                  child: const Text(
                                    "ورود",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

