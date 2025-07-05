import 'package:deu_cis/product/enums/image_constants.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/index.dart';

class AgendaListItem extends StatelessWidget {
  AgendaListItem(
      {super.key,
      required this.eventSession,
      required this.onTapFunction,
      required this.trialingFunction});
  EventSession? eventSession;
  final VoidCallback? trialingFunction;
  final VoidCallback? onTapFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: AppColors.white,
        child: ListTile(
            onTap: onTapFunction,
            leading: Text(
              '${eventSession?.startDate != null ? DateFormat('HH:mm').format(eventSession!.startDate!.toLocal()) : ''} \n'
              '${eventSession?.endDate != null ? DateFormat('HH:mm').format(eventSession!.endDate!.toLocal()) : ''}',
            ),
            title:
                eventSession != null ? Text(eventSession?.title ?? '') : null,
            subtitle: eventSession != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(eventSession?.location ?? ''),
                      Text(
                        eventSession?.speaker == null ||
                                eventSession!.speaker!.isEmpty
                            ? ''
                            : eventSession!.speaker!.length == 1
                                ? '${StringConsts.speaker} ${eventSession!.speaker![0].firstName} ${eventSession!.speaker![0].lastName}'
                                : '${StringConsts.speakers} ' +
                                    eventSession!.speaker!
                                        .map((spk) =>
                                            '${spk.firstName} ${spk.lastName}')
                                        .join(', '),
                      )
                    ],
                  )
                : null,
            trailing: eventSession != null &&
                    eventSession!.startDate!.compareTo(DateTime.now()) > 0
                ? InkWell(
                    onTap: trialingFunction,
                    child: (eventSession!.isAdded!)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SVGConstants.calenderAdded.toSVG,
                              Text(StringConsts.addedAgenda),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SVGConstants.calenderAdd.toSVG,
                              Text(StringConsts.addAgenda),
                            ],
                          ),
                  )
                : null));
  }
}

class UserAgendaListItem extends StatelessWidget {
  UserAgendaListItem(
      {super.key,
      required this.userAgendaSession,
      required this.onTapFunction,
      required this.trialingFunction});
  UserAgendaSession? userAgendaSession;
  final VoidCallback? trialingFunction;
  final VoidCallback? onTapFunction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: AppColors.white,
      child: ListTile(
        onTap: onTapFunction,
        leading: Text(
          '${userAgendaSession?.startDate != null ? DateFormat('HH:mm').format(userAgendaSession!.startDate!.toLocal()) : ''} \n'
          '${userAgendaSession?.endDate != null ? DateFormat('HH:mm').format(userAgendaSession!.endDate!.toLocal()) : ''}',
        ),
        title: userAgendaSession != null
            ? Text(userAgendaSession?.title ?? '')
            : null,
        subtitle: userAgendaSession != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userAgendaSession?.location ?? ''),
                  Text(
                    userAgendaSession?.speaker == null ||
                            userAgendaSession!.speaker!.isEmpty
                        ? ''
                        : userAgendaSession!.speaker!.length == 1
                            ? '${StringConsts.speaker} ${userAgendaSession!.speaker![0].firstName} ${userAgendaSession!.speaker![0].lastName}'
                            : '${StringConsts.speakers} ' +
                                userAgendaSession!.speaker!
                                    .map((spk) =>
                                        '${spk.firstName} ${spk.lastName}')
                                    .join(', '),
                  )
                ],
              )
            : null,
        trailing: InkWell(
          onTap: trialingFunction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SVGConstants.calenderAdded.toSVG,
              Text(StringConsts.addedAgenda),
            ],
          ),
        ),
      ),
    );
  }
}
