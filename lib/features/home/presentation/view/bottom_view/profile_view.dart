// profile_view.dart

import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fitbit/config/constants/api_endpoint.dart';
import 'package:fitbit/config/router/app_route.dart';
import 'package:fitbit/core/common/snackbar/my_snackbar.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  var gap = const SizedBox(
    height: 20,
  );

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String? userImage;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchUserData();
  // }

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

  ShakeDetector? detector;

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(
      onPhoneShake: () async {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: 'basic_channel',
            title: "Log Out",
            body: "You are logged out!",
          ),
        );
        showSnackBar(message: 'You are logged out', context: context);
        Navigator.pushNamed(context, AppRoute.loginRoute);
      },
    );
  }

  @override
  void dispose() {
    detector!.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 112, 110, 110),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: FutureBuilder<void>(
              future: fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // Handle error if any
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return buildProfileContent();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchUserData() async {
    var authState = ref.watch(authViewModelProvider);
    var user = authState.user!;
    firstNameController.text = user.firstname;
    lastNameController.text = user.lastname;
    ageController.text = user.age;
    genderController.text = user.gender;
    emailController.text = user.email;
    usernameController.text = user.username;
    userImage = user.image;
  }

  Widget buildProfileContent() {
    var authState = ref.watch(authViewModelProvider);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset('assets/images/logo.png'),
            ),
            Positioned(
              left: 0,
              bottom: -70,
              child: InkWell(
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
                        : NetworkImage(
                            ApiEndpoints.imageUrl + (userImage ?? ''),
                          ) as ImageProvider,
                  ),
                ),
              ),
            ),
          ],
        ),
        gap,
        gap,
        gap,
        gap,
        gap,
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            '${authState.user!.firstname} ${authState.user!.lastname}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        gap,
        TextFormField(
          controller: firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
        ),
        gap,
        TextFormField(
          controller: lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
        ),
        gap,
        TextFormField(
          controller: ageController,
          decoration: const InputDecoration(
            labelText: 'Age',
            border: OutlineInputBorder(),
          ),
        ),
        gap,
        TextFormField(
          controller: genderController,
          decoration: const InputDecoration(
            labelText: 'Gender',
            border: OutlineInputBorder(),
          ),
        ),
        gap,
        TextFormField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        gap,
        TextFormField(
          controller: usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        gap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                updateUserData();
                Navigator.pushNamed(context, AppRoute.dashboardRoute);
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.loginRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Delete',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> updateUserData() async {
    final authState = ref.watch(authViewModelProvider);
    String userId = authState.user!.userID!;

    // Fetch the updated values from the text fields
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String age = ageController.text;
    String gender = genderController.text;
    String email = emailController.text;
    String username = usernameController.text;

    String? updatedImage;

    if (_img != null) {
      // Call the view model to upload the new image
      updatedImage = ref.read(authViewModelProvider).imageName ?? '';
    }

    // Create a new UserEntity with the updated values
    var updatedUser = UserEntity(
      // userID: authState.user!.userID,
      firstname: firstName,
      lastname: lastName,
      age: age,
      gender: gender,
      email: email,
      username: username,
      password: authState.user!.password,
      image: updatedImage ?? userImage,
    );

    // Call the view model to update the user data
    ref
        .read(authViewModelProvider.notifier)
        .updateUser(context, userId, updatedUser);
  }
}
