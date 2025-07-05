import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/snackbar_result.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/user_session_rate.dart';
import 'package:deu_cis/product/vm/session_rating_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionRatingView extends StatefulWidget {
  SessionRatingView({
    super.key,
    required this.userID,
    required this.sessionID,
  });
  int userID;
  int sessionID;
  @override
  State<SessionRatingView> createState() => _SessionRatingViewState();
}

class _SessionRatingViewState extends State<SessionRatingView> {
  bool _isLoading = true;
  bool _isUpdate = false;
  TextEditingController commnetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    await locator<SessionRatingViewModel>()
        .fetchUserSessionRate(widget.sessionID, widget.userID)
        .then(
      (value) {
        if (locator<SessionRatingViewModel>()
                .userSessionRate
                ?.q1ExpectationScore !=
            null) {
          _isUpdate = true;
          commnetController.text =
              locator<SessionRatingViewModel>().userSessionRate!.comment ?? '';
        }
        _isLoading = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(),
            body: ChangeNotifierProvider.value(
                value: locator<SessionRatingViewModel>(),
                child: Consumer<SessionRatingViewModel>(
                    builder: (context, sessionRatingViewModel, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: ListView(
                      children: [
                        Text('Etkinlik beklentilerinizi ne kadar karşıladı?'),
                        Row(
                          children: [
                            ..._ratingWidget(
                              value: sessionRatingViewModel
                                  .userSessionRate?.q1ExpectationScore,
                              onChanged: (val) {
                                sessionRatingViewModel
                                    .updateExpectationScore(val);
                              },
                            )
                          ],
                        ),
                        Text(
                            'Konuşmacının sunum becerilerini nasıl değerlendirirsiniz?'),
                        Row(
                          children: [
                            ..._ratingWidget(
                              value: sessionRatingViewModel
                                  .userSessionRate?.q2PresentationScore,
                              onChanged: (val) {
                                sessionRatingViewModel
                                    .updatePresentationScore(val);
                              },
                            )
                          ],
                        ),
                        Text(
                            'Konuşmacının konuya hakimiyetini nasıl değerlendirirsiniz?'),
                        Row(
                          children: [
                            ..._ratingWidget(
                              value: sessionRatingViewModel
                                  .userSessionRate?.q3MasteryScore,
                              onChanged: (val) {
                                sessionRatingViewModel.updateMasteryScore(val);
                              },
                            )
                          ],
                        ),
                        Text('Konu açıklaması oturum içeriğiyle uyuştu mu?'),
                        Row(
                          children: [
                            ..._ratingWidget(
                              value: sessionRatingViewModel
                                  .userSessionRate?.q4TopicAlignmentScore,
                              onChanged: (val) {
                                sessionRatingViewModel
                                    .updateTopicAlignmentScore(val);
                              },
                            )
                          ],
                        ),
                        Text(
                            'Genel olarak bu oturumu nasıl değerlendirirsiniz?'),
                        Row(
                          children: [
                            ..._ratingWidget(
                              value: sessionRatingViewModel
                                  .userSessionRate?.q5OverallScore,
                              onChanged: (val) {
                                sessionRatingViewModel.updateOverallScore(val);
                              },
                            )
                          ],
                        ),
                        Text('Önerir misiniz?'),
                        SizedBox(
                          height: 35,
                          child: RadioListTile(
                            title: Text(StringConsts.yes),
                            value: 1,
                            groupValue: sessionRatingViewModel
                                .userSessionRate?.q6Recommendation,
                            onChanged: (value) {
                              sessionRatingViewModel.updateRecommendation(1);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 35,
                          child: RadioListTile(
                            title: Text(StringConsts.no),
                            value: 0,
                            groupValue: sessionRatingViewModel
                                .userSessionRate?.q6Recommendation,
                            onChanged: (value) {
                              sessionRatingViewModel.updateRecommendation(0);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Yorumunuz'),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: TextField(
                            onChanged: (value) {
                              sessionRatingViewModel.updateComment(value);
                            },
                            controller: commnetController,
                            maxLines: 4,
                            minLines: 2,
                            decoration: InputDecoration(
                              hintText: "Yorumunuzu buraya yazın...",
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                backgroundColor:
                                    _isValid(sessionRatingViewModel)
                                        ? MaterialStateProperty.all(
                                            AppColors.themeColor)
                                        : MaterialStateProperty.all(
                                            AppColors.blueLight)),
                            onPressed: _isValid(sessionRatingViewModel)
                                ? () async {
                                    bool result = false;
                                    if (_isUpdate) {
                                      result = await sessionRatingViewModel
                                          .updateUserSessionRating(
                                              sessionRatingViewModel
                                                  .userSessionRate!
                                                  .copyWith(
                                                      userId: widget.userID,
                                                      eventSessionId:
                                                          widget.sessionID));
                                    } else {
                                      result = await sessionRatingViewModel
                                          .addUserSessionRating(
                                              sessionRatingViewModel
                                                  .userSessionRate!
                                                  .copyWith(
                                                      userId: widget.userID,
                                                      eventSessionId:
                                                          widget.sessionID));
                                      if (result) {
                                        _isUpdate = true;
                                        setState(() {});
                                      }
                                    }
                                    SnackBarResponse(context: context)
                                        .showResponse(
                                            result,
                                            result
                                                ? 'Değerlendirme başarılı.'
                                                : 'Değerlendirme başarısız');
                                  }
                                : null,
                            child: Text(
                              _isUpdate ? 'Güncelle' : 'Gönder',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })),
          );
  }

  List<Widget> _ratingWidget({
    required int? value,
    required Function(int?) onChanged,
  }) {
    return List.generate(5, (index) {
      return IconButton(
        icon: Icon(
          value != null && index < value ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 32,
        ),
        onPressed: () {
          onChanged(index + 1);
        },
      );
    });
  }

  bool _isValid(SessionRatingViewModel sessionRatingViewModel) {
    final userSessionRate = sessionRatingViewModel.userSessionRate;
    return userSessionRate != null &&
        userSessionRate.q1ExpectationScore != null &&
        userSessionRate.q2PresentationScore != null &&
        userSessionRate.q3MasteryScore != null &&
        userSessionRate.q4TopicAlignmentScore != null &&
        userSessionRate.q5OverallScore != null &&
        userSessionRate.q6Recommendation != null &&
        userSessionRate.comment != null;
  }
}
