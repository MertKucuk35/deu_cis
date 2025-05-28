import 'package:deu_cis/feature/home/subview/events/event_detail/subview/subview/event_speakers_view.dart';
import 'package:deu_cis/product/vm/event_attendes_view_model.dart';
import 'package:deu_cis/product/vm/user_agenda_view_model.dart';
import 'package:deu_cis/product/vm/event_agenda_view_model.dart';
import 'package:deu_cis/feature/home/subview/events/event_view_model.dart';
import 'package:deu_cis/product/vm/combined_agenda_view_model.dart';

import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthViewModel>(AuthViewModel());
  locator.registerSingleton<EventViewModel>(EventViewModel());
  locator.registerSingleton<EventAgendaViewModel>(EventAgendaViewModel());
  locator.registerSingleton<UserAgendaViewModel>(UserAgendaViewModel());
  locator.registerSingleton<EventAttendesViewModel>(EventAttendesViewModel());

  // locator.registerLazySingleton<AuthViewModel>(() => AuthViewModel());
  // locator.registerLazySingleton<EventViewModel>(() => EventViewModel());

  // locator.registerLazySingleton<EventAgendaViewModel>(
  //     () => EventAgendaViewModel());
  // locator
  //     .registerLazySingleton<UserAgendaViewModel>(() => UserAgendaViewModel());
}
