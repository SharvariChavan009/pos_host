import 'dart:io';
import 'package:flutter/material.dart';
import 'package:host_task/core/common/c_text_field.dart';
import 'package:host_task/core/common/colors.dart';
import 'package:image_picker/image_picker.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
// -----------------------------------------

    TextEditingController signupnameController = TextEditingController();
    TextEditingController signupemailController = TextEditingController();
    TextEditingController signuppinController = TextEditingController();
    TextEditingController signupconfirmController = TextEditingController();

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    print("Screen Height: $screenHeight");
    print("Screen Width: $screenWidth");

    File? _imgFile;

    void takeSnapshot() async {
      final ImagePicker picker = ImagePicker();
      final XFile? img = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 400,
      );
      if (img == null) return;
      setState(() {
        _imgFile = File(img.path);
      });
    }

// -----------------------------------------

    return Scaffold(
      backgroundColor: AppColors.darkColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkColor,
        title: const Text(
          "QuickDine",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          ),
          height: screenHeight * 0.68,
          width: screenWidth * 0.90,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundImage: (_imgFile == null)
                      ? const NetworkImage(
                          "https://png.pngitem.com/pimgs/s/105-1050694_user-placeholder-image-png-transparent-png.png")
                      : FileImage(_imgFile!) as ImageProvider,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      takeSnapshot();
                    },
                    child: const Text(
                      "Add Photo",
                      style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "(Optional)",
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 18),
                  ),
                ),

                // Name Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: screenWidth * 0.84,
                    child: CustomTextField(
                      controller: signupnameController,
                      hintText: "Name",
                      borderColor: AppColors.buttonColor,
                    ),
                  ),
                ),
                // Email Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: screenWidth * 0.84,
                    child: CustomTextField(
                      controller: signupemailController,
                      hintText: "Email",
                      borderColor: AppColors.buttonColor,
                    ),
                  ),
                ),
                // Phone Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: screenWidth * 0.84,
                    child: CustomTextField(
                      controller:signupconfirmController ,
                      hintText: "Phone (Optional)",
                      borderColor: AppColors.buttonColor,
                    ),
                  ),
                ),
                // Set Pin Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: screenWidth * 0.84,
                    child: CustomTextField(
                      controller: signuppinController,
                      hintText: "Set Your PIN",
                      borderColor: AppColors.buttonColor,
                    ),
                  ),
                ),
                // Confirm Pin Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    width: screenWidth * 0.84,
                    child: CustomTextField(
                      controller: signupconfirmController,
                      hintText: "Confirm PIN",
                      borderColor: AppColors.buttonColor,
                    ),
                  ),
                ),

                // Signup Button
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
