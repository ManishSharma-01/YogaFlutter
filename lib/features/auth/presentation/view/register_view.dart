import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../../core/common/widgets/textfield_widget.dart';
import '../../domain/entity/user_entity.dart';
import '../viewmodel/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final usernameController = TextEditingController(text: '');
  final firstnameController = TextEditingController(text: '');
  final lastnameController = TextEditingController(text: '');
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final confirmPasswordController = TextEditingController(text: '');
  final ageController = TextEditingController(text: '');
  final genderController = TextEditingController(text: '');
  final key = GlobalKey<FormState>();

  String gender = 'Male';

  void handleGenderChange(String value) {
    setState(() {
      gender = value;
    });
  }

  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  var gap = const SizedBox(
    height: 20,
  );

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;

  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(authViewModelProvider.notifier).uploadImage(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Column(
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        gap,
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              RichText(
                                text: const TextSpan(
                                  text: 'Sign up to get started',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    gap,
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.grey[300],
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    checkCameraPermission();
                                    _browseImage(ref, ImageSource.camera);
                                    Navigator.pop(context);
                                    // Upload image it is not null
                                  },
                                  icon: const Icon(Icons.camera),
                                  label: const Text('Camera'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    _browseImage(ref, ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.image),
                                  label: const Text('Gallery'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _img != null
                              ? FileImage(_img!)
                              : const AssetImage('assets/images/profile.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    gap,
                    customTextField(usernameController, 'Username'),
                    gap,
                    customTextField(firstnameController, 'First Name'),
                    gap,
                    customTextField(lastnameController, 'Last Name'),
                    gap,
                    customTextField(emailController, 'Email'),
                    gap,
                    TextFormField(
                      controller: passwordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: togglePasswordVisibility,
                          child: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    gap,
                    customTextField(ageController, 'Age'),
                    gap,
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RadioListTile(
                      title: const Text(
                        'Male',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (value) => handleGenderChange('Male'),
                    ),
                    RadioListTile(
                      title: const Text(
                        'Female',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (value) => handleGenderChange('Female'),
                    ),
                    RadioListTile(
                      title: const Text(
                        'Others',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      value: 'Others',
                      groupValue: gender,
                      onChanged: (value) => handleGenderChange('Others'),
                    ),
                    gap,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {
                            var user = UserEntity(
                              firstname: firstnameController.text,
                              lastname: lastnameController.text,
                              email: emailController.text,
                              username: usernameController.text,
                              password: passwordController.text,
                              age: ageController.text,
                              gender: gender,
                              image:
                                  ref.read(authViewModelProvider).imageName ??
                                      '',
                            );

                            ref
                                .read(authViewModelProvider.notifier)
                                .registerUser(context, user);

                            if (authState.error != null) {
                              showSnackBar(
                                message: authState.error.toString(),
                                context: context,
                                color: Colors.red,
                              );
                            }
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
                    gap,
                    gap,
                    const Text(
                      'Already have an Account?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 62, 62, 62),
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoute.loginRoute);
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
