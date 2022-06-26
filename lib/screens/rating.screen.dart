import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jii_comic_mobile/models/rating_props.dart';
import 'package:jii_comic_mobile/providers/index.dart';
import 'package:jii_comic_mobile/utils/color_constants.dart';
import 'package:jii_comic_mobile/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

class RatingScreen extends StatefulWidget {
  static const String routeName = "/rating";
  const RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  late final _comicId;
  String? _ratingId;
  final _ratingContentController = TextEditingController();
  double _ratingScore = 0;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final canAccessScreen =
            await context.read<AuthProvider>().checkActiveSession(context);
        if (!canAccessScreen) {
          Navigator.of(context).pop();
          await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Thông báo"),
              content: Text("Vui lòng đăng nhập!"),
            ),
          );

          return;
        }

        final props = ModalRoute.of(context)!.settings.arguments as RatingProps;
        setState(() {
          _comicId = props.comicId;
          _ratingId = props.ratingId;
          _ratingScore = props.ratingScore ?? 0;
          _ratingContentController.text = props.content ?? "";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _submitRating() async {
      final ratingSuccessful = await context.read<ComicsProvider>().rateComic(
          context,
          comicId: _comicId,
          ratingId: _ratingId,
          ratingScore: _ratingScore,
          content: _ratingContentController.text);

      if (ratingSuccessful) {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text("Đánh giá truyện"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  ColorConstants.gradientFirstColor,
                  ColorConstants.gradientSecondColor,
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                RatingBar.builder(
                    allowHalfRating: true,
                    initialRating: _ratingScore,
                    itemBuilder: (context, _) => FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.yellow[600]),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _ratingScore = rating;
                      });
                    }),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _ratingContentController,
                    decoration: InputDecoration(
                      hintText: "Viết đánh giá của bạn tại đây...",
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
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                PrimaryButton(
                    child: Text("Lưu đánh giá"), onPressed: _submitRating)
              ],
            )));
  }
}
