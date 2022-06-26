import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jii_comic_mobile/providers/index.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _submit() async {
      await context.read<AuthProvider>().register(context,
          email: _email.text,
          password: _password.text,
          confirmPassword: _confirmPassword.text,
          name: _name.text);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 105, right: 16, left: 16, bottom: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Đăng kí",
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
                _renderInput(label: "Tên", controller: _name),
                SizedBox(
                  height: 24,
                ),
                _renderInput(
                    label: "Mật khẩu", controller: _password, encrypted: true),
                SizedBox(
                  height: 24,
                ),
                _renderInput(
                    label: "Nhập lại mật khẩu",
                    controller: _confirmPassword,
                    encrypted: true),
                SizedBox(
                  height: 24,
                ),
                PrimaryButton(
                  child: Text("Đăng kí".toUpperCase()),
                  onPressed: _submit,
                ),
                SizedBox(
                  height: 20,
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                    children: [
                      TextSpan(text: "Bằng cách đăng kí, bạn đồng ý với" + " "),
                      TextSpan(
                        text: "điều khoản và dịch vụ" + " ",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      TextSpan(text: "của Jii Comic"),
                    ],
                  ),
                )
              ],
            ),
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
