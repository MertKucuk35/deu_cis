import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/enums/user_note_types.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_attende.dart';
import 'package:deu_cis/product/models/user_notes.dart';
import 'package:deu_cis/product/utility/month_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class UserNotesListItem extends StatelessWidget {
  UserNotesListItem({
    super.key,
    required this.userNote,
    this.function,
  });

  final UserNote userNote;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: AppColors.white,
        child: ListTile(
          leading: userNote.meta is PersonMeta
              ? ((userNote.meta as PersonMeta).getImageURL() != null
                  ? CachedImage(
                      imageUrl: (userNote.meta as PersonMeta).getImageURL(),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: ResponsiveBreakpoints.of(context).isMobile
                          ? MediaQuery.of(context).size.width * 0.2
                          : MediaQuery.of(context).size.height * 0.2,
                    )
                  : Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        // width: MediaQuery.of(context).size.width * 0.2,
                        // height: MediaQuery.of(context).size.width * 0.2,
                        child: Icon(
                          Icons.event,
                          size: ResponsiveBreakpoints.of(context).isMobile
                              ? MediaQuery.of(context).size.width * 0.2
                              : MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                    ))
              : Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: ResponsiveBreakpoints.of(context).isMobile
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.height * 0.2,
                  child: Icon(
                    Icons.calendar_month,
                  )),
          title: Text(
            userNote.meta is PersonMeta
                ? ((userNote.meta as PersonMeta).fullName ?? '')
                : (userNote.meta is EventSessionMeta
                    ? ((userNote.meta as EventSessionMeta).sessionTitle ?? '')
                    : ''),
            style: AppTextStyles.titleTextBlack,
          ),
          subtitle: Text(userNote.noteText ?? ''),
        ),
      ),
    );
  }
}
