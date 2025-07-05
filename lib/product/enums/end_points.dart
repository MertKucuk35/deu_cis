enum MainEndPoints {
  users,
  events,
  event_sessions,
  speakers,
  attendes,
  institutions,
  ratings,
  fcm_tokens,
  messages,
  notes,
  contacts,
  istatistics
}

enum UsersEndpoints { login, loginJWT, getUser, updateUser, public_profile }

enum EventsEndpoints {
  getEventById,
}

enum EventSessionsEndpoints {
  getEventById,
  user_agenda,
  user_agenda_add,
  user_agenda_delete,
  single
}

enum InstitutionsEndpoints { sponsors, organizers, institution_history }

enum RatingsEndpoints {
  user_session_rating,
  user_session_rating_add,
  user_session_rating_update
}

enum FcmTokensEndpoints {
  user_fcm_tokens,
  user_fcm_tokens_add,
  user_fcm_tokens_update
}

enum MessagesEndpoints {
  user_chat_messages,
  // user_chat_messages_add,
  // user_chat_messages_update,
  // user_chat_messages_delete
}

enum NotesEndpoints {
  user_notes,
  user_note_add,
  user_note_update,
  user_note_delete
}

enum IstatisticsEndPoints { top_rated_sessions }
