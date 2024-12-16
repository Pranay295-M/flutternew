import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/home.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "", password = "", phoneNumber = "", otp = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isPhoneLogin = false; // Toggle between email and phone login
  bool isLoading = false; // To show loading indicator
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? verificationId; // To store the verification ID for OTP login

  // Function to login with email
  Future<void> loginWithEmail() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email. Please check the email address or register.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password. Please check your password or reset it.';
      } else {
        errorMessage = 'An error occurred. Please try again later.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to send OTP
  Future<void> sendOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber', // Add country code
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => home()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Verification failed: ${e.message}')),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            this.verificationId = verificationId;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP sent successfully!')),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Function to verify OTP
  Future<void> verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => home()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: const Text('WasteWisePro'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isPhoneLogin ? 'Login with Phone' : 'Login with Email',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  const SizedBox(height: 30),

                  // Toggle Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isPhoneLogin = false;
                          });
                        },
                        child: const Text('Login with Email'),
                      ),
                      const Text(' | '),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isPhoneLogin = true;
                          });
                        },
                        child: const Text('Login with Phone'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Email Login Section
                  if (!isPhoneLogin) ...[
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'youremail@domain.com',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.email, color: Colors.green),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.lock, color: Colors.green),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          loginWithEmail();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[700],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                  ],

                  // Phone Login Section
                  if (isPhoneLogin) ...[
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: const Icon(Icons.phone, color: Colors.green),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter phone number';
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            phoneNumber = phoneController.text;
                          });
                          sendOtp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[700],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Send OTP'),
                    ),
                    const SizedBox(height: 16),
                    if (verificationId != null) ...[
                      TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter OTP',
                          hintText: '123456',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: const Icon(Icons.lock, color: Colors.green),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter OTP';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            otp = otpController.text;
                          });
                          verifyOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[700],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Verify OTP'),
                      ),
                    ],
                  ],

                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Register()),
                      );
                    },
                    child: const Text(
                      'New User? Register Here',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}