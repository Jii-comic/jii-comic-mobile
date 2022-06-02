import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      await Provider.of<AuthProvider>(context, listen: false).login(
          context: context, email: _email.text, password: _password.text);
    }

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
              _renderInput(
                  label: "Email",
                  placeholder: "abc@abc.com",
                  controller: _email),
              SizedBox(
                height: 24,
              ),
              _renderInput(
                  label: "Mật khẩu", controller: _password, encrypted: true),
              SizedBox(
                height: 24,
              ),
              PrimaryButton(
                  child: Text("Đăng nhập".toUpperCase()), onPressed: _submit)
            ],
          ),
        ),
      ),
    );
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
}
