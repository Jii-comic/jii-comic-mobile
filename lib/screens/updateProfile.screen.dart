// import 'dart:html';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:jii_comic_mobile/widgets/avatar.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const routeName = "/updateProfile";
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).currentUser;
    void _submit() async {
      await Provider.of<AuthProvider>(context, listen: false).login(
          context: context, email: _email.text, password: _password.text);
    }

    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          color: Colors.black,
          onPressed: () {},
        ),
        title: Text("Chỉnh sửa thông tin"),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              children: [
                Stack(
                  children: [
                    Avatar(
                      avatarUrl: "null",
                      radius: 70.0,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 200,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.camera,
                              color: Colors.black,
                              size: 16,
                            ),
                            onPressed: () async {
                              // final XFile? image = await _picker.pickImage(
                              //     source: ImageSource.gallery);
                              // print("image $image");
                            },
                          ),
                        )),
                  ],
                ),
                // Container(
                //   width: 140,
                //   height: 140,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: DecorationImage(
                //           image: AssetImage('assets/images/greeting-bg.jpg'),
                //           fit: BoxFit.cover)),
                // ),
                Container(
                  padding: EdgeInsets.only(top: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        _renderInput(
                            label: "Tên hiển thị",
                            placeholder: "abc",
                            controller: _username),
                        SizedBox(
                          height: 24,
                        ),
                        _renderInput(
                            label: "Email",
                            placeholder: "abc@abc.com",
                            controller: _email),
                        SizedBox(
                          height: 24,
                        ),
                        _renderInput(
                            label: "Mật khẩu",
                            controller: _password,
                            encrypted: true),
                        SizedBox(
                          height: 24,
                        ),
                        PrimaryButton(
                            child: Text("Đăng nhập".toUpperCase()),
                            onPressed: _submit)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _renderInput(
    {required label,
    placeholder = "",
    required controller,
    bool encrypted = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      SizedBox(
        height: 8,
      ),
      TextFormField(
        controller: controller,
        obscureText: encrypted,
        enableSuggestions: !encrypted,
        autocorrect: !encrypted,
        decoration: InputDecoration(
          hintText: placeholder,
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
      )
    ],
  );
}
