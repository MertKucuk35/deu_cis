import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/user_notes.dart';
import 'package:flutter/material.dart';

class UserNoteDetailView extends StatefulWidget {
  UserNoteDetailView({super.key, required this.userNote});

  UserNote? userNote;

  @override
  State<UserNoteDetailView> createState() => _UserNoteDetailViewState();
}

class _UserNoteDetailViewState extends State<UserNoteDetailView> {
  TextEditingController commentController = TextEditingController();
  bool _isUpdate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userNote?.createdAt != null) {
      commentController.text = widget.userNote?.noteText ?? '';
      _isUpdate = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.greyLight,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: commentController,
                  minLines: 5,
                  maxLines: 10,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                    backgroundColor: commentController.text != ''
                        ? MaterialStateProperty.all(AppColors.themeColor)
                        : MaterialStateProperty.all(AppColors.blueLight)),
                onPressed: () {},
                child: Text(
                  _isUpdate ? 'Güncelle' : 'Kaydet',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
