import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEEE),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 105, right: 16, left: 16, bottom: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Đăng nhập",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 24,
              ),
              _renderInput(label: "Email", placeholder: "abc@abc.com"),
              SizedBox(
                height: 24,
              ),
              _renderInput(label: "Mật khẩu"),
              SizedBox(
                height: 24,
              ),
              PrimaryButton(
                  child: Text("Đăng nhập".toUpperCase()), onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderInput({required label, placeholder = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(
          height: 8,
        ),
        TextFormField(
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
}
