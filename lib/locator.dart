import 'package:deu_cis/product/vm/event_attendes_view_model.dart';
import 'package:deu_cis/product/vm/event_institution_view_model.dart';
import 'package:deu_cis/product/vm/event_session_istatistics_view_model.dart';
import 'package:deu_cis/product/vm/session_rating_view_model.dart';
import 'package:deu_cis/product/vm/user_agenda_view_model.dart';
import 'package:deu_cis/product/vm/event_agenda_view_model.dart';
import 'package:deu_cis/product/vm/event_view_model.dart';

import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/product/vm/user_note_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthViewModel>(AuthViewModel());
  locator.registerSingleton<EventViewModel>(EventViewModel());
  locator.registerSingleton<EventAgendaViewModel>(EventAgendaViewModel());
  locator.registerSingleton<UserAgendaViewModel>(UserAgendaViewModel());
  locator.registerSingleton<EventAttendesViewModel>(EventAttendesViewModel());
  locator.registerSingleton<EventInstitutionViewModel>(
      EventInstitutionViewModel());
  locator.registerLazySingleton<SessionRatingViewModel>(
      () => SessionRatingViewModel());

  locator.registerSingleton<UserNoteViewModel>(UserNoteViewModel());
  locator.registerSingleton<EventSessionIstatisticsViewModel>(
      EventSessionIstatisticsViewModel());
  // locator.registerSingleton<SessionRatingViewModel>(SessionRatingViewModel());

  // locator.registerLazySingleton<AuthViewModel>(() => AuthViewModel());
  // locator.registerLazySingleton<EventViewModel>(() => EventViewModel());

  // locator.registerLazySingleton<EventAgendaViewModel>(
  //     () => EventAgendaViewModel());
  // locator
  //     .registerLazySingleton<UserAgendaViewModel>(() => UserAgendaViewModel());
}
