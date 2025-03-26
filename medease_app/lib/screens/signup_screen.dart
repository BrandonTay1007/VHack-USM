import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;

  @override
  void initState() {
    super.initState();
    confirmPasswordFocusNode.addListener(() {
      if (confirmPasswordFocusNode.hasFocus) {
        checkPasswordValidity();
      }
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool validatePassword(String password) {
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%]).{8,32}$');
    return passwordRegex.hasMatch(password);
  }

  void checkPasswordValidity() {
    setState(() {
      isPasswordValid = validatePassword(passwordController.text);
      isConfirmPasswordValid = passwordController.text == confirmPasswordController.text;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         Positioned.fill(
  //           child: Image.asset(
  //             "assets/images/background.png",
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         SingleChildScrollView(
  //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               IconButton(
  //                 icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //               ),
  //               const SizedBox(height: 20),
  //               const Text(
  //                 "Sign Up",
  //                 style: TextStyle(
  //                   fontSize: 38,
  //                   fontFamily: 'Poppins Bold',
  //                   fontWeight: FontWeight.w800,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //               const SizedBox(height: 20),
  //               _buildTextField(label: "Email", controller: emailController),
  //               _buildPasswordField(
  //                 label: "Password",
  //                 controller: passwordController,
  //                 isVisible: isPasswordVisible,
  //                 toggleVisibility: () {
  //                   setState(() {
  //                     isPasswordVisible = !isPasswordVisible;
  //                   });
  //                 },
  //                 onChanged: checkPasswordValidity,
  //               ),
  //               _passwordRequirements(), // ✅ Added back to prevent errors
  //               if (!isPasswordValid)
  //                 const Padding(
  //                   padding: EdgeInsets.only(bottom: 10),
  //                   child: Text(
  //                     "Invalid password. Please try again.",
  //                     style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.red, decoration: TextDecoration.underline, decorationColor: Colors.red),
  //                   ),
  //                 ),
  //               _buildPasswordField(
  //                 label: "Confirm Password",
  //                 controller: confirmPasswordController,
  //                 isVisible: isConfirmPasswordVisible,
  //                 toggleVisibility: () {
  //                   setState(() {
  //                     isConfirmPasswordVisible = !isConfirmPasswordVisible;
  //                   });
  //                 },
  //                 onChanged: checkPasswordValidity,
  //                 focusNode: confirmPasswordFocusNode,
  //               ),
  //               if (!isConfirmPasswordValid)
  //                 const Padding(
  //                   padding: EdgeInsets.only(bottom: 10),
  //                   child: Text(
  //                     "Passwords do not match. Please try again.",
  //                     style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.red, decoration: TextDecoration.underline, decorationColor: Colors.red),
  //                   ),
  //                 ),
  //               const SizedBox(height: 20),
  //               Center(
  //                 child: ElevatedButton(
  //                   onPressed: () {
  //                     if (isPasswordValid && isConfirmPasswordValid) {
  //                       /// ✅ Navigate to Profile Setup Page
  //                       Navigator.pushNamed(context, '/profile_setup');
  //                     }
  //                   },
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: const Color(0xFFD6BFFF),
  //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //                   ),
  //                   child: const SizedBox(
  //                     width: 236,
  //                     height: 54,
  //                     child: Center(
  //                       child: Text(
  //                         "Create Account",
  //                         style: TextStyle(color: Colors.black),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(height: 10),
  //               Center(
  //                 child: Column(
  //                   children: [
  //                     const Text(
  //                       "Already have an Account?",
  //                       style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.black),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         Navigator.pushNamed(context, "/login");
  //                       },
  //                       child: const Text(
  //                         "LOGIN",
  //                         style: TextStyle(
  //                           fontSize: 14,
  //                           fontFamily: 'Poppins',
  //                           fontWeight: FontWeight.bold,
  //                           color: Color.fromARGB(255, 33, 75, 243),
  //                           decoration: TextDecoration.underline,
  //                           decorationColor: Color.fromARGB(255, 33, 65, 243),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
Widget build(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/background.png"),
        fit: BoxFit.cover, // Ensures the background covers the whole page
      ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent, // Makes Scaffold transparent
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 38,
                fontFamily: 'Poppins Bold',
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(label: "Email", controller: emailController),
            _buildPasswordField(
              label: "Password",
              controller: passwordController,
              isVisible: isPasswordVisible,
              toggleVisibility: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              onChanged: checkPasswordValidity,
            ),
            _passwordRequirements(),
            if (!isPasswordValid)
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Invalid password. Please try again.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
            _buildPasswordField(
              label: "Confirm Password",
              controller: confirmPasswordController,
              isVisible: isConfirmPasswordVisible,
              toggleVisibility: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
              onChanged: checkPasswordValidity,
              focusNode: confirmPasswordFocusNode,
            ),
            if (!isConfirmPasswordValid)
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Passwords do not match. Please try again.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (isPasswordValid && isConfirmPasswordValid) {
                    Navigator.pushNamed(context, '/profile_setup');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6BFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const SizedBox(
                  width: 236,
                  height: 54,
                  child: Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 33, 75, 243),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromARGB(255, 33, 65, 243),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  Widget _buildTextField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontFamily: 'Poppins', color: Colors.black)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggleVisibility,
    required VoidCallback onChanged,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontFamily: 'Poppins', color: Colors.black)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              obscureText: !isVisible,
              focusNode: focusNode,
              onChanged: (value) => onChanged(),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                suffixIcon: IconButton(
                  icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: toggleVisibility,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _passwordRequirements() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Your password must include:",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 5),
      _requirementItem("8-32 characters long"),
      _requirementItem("1 lowercase character (a-z)"),
      _requirementItem("1 uppercase character (A-Z)"),
      _requirementItem("1 number"),
      _requirementItem("1 special character e.g. ! @ # \$ %"),
    ],
  );
}

Widget _requirementItem(String text) {
  return Row(
    children: [
      const Icon(Icons.check, color: Colors.green, size: 18), // Green check icon
      const SizedBox(width: 8),
      Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    ],
  );
}}
