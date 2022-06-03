// import 'dart:html';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/user.model.dart';
import 'package:jii_comic_mobile/providers/auth.provider.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const routeName = "/updateProfile";
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushNamed(context, "/profile");
  }


  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<AuthProvider>(context).currentUser;
    void _submit() async {
      await Provider.of<AuthProvider>(context, listen: false).login(
          context: context, email: _email.text, password: _password.text);
    }


    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          color: Colors.black,
          onPressed: (){},
        ),
        title: Text("CHỈNH SỬA THÔNG TIN"),
        foregroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {}, icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket),color: Colors.black,
          )
        ],
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.list),
            label: "Manga",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bookmark),
            label: "My List",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),

    );
  }
  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(color: Colors.white, ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/greeting-bg.jpg'),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "tên here",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "email here",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 20,
              ),
              _renderInput(
                  label: "Tên Hiển Thị",
                  placeholder: "",
                  controller: _email),
              SizedBox(
                height: 20,
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
                  child: Text("lưu thay đổi".toUpperCase()), onPressed: (){})
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
