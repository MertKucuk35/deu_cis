enum MainEndPoints { users, events, event_sessions, speakers, attendes }

enum UsersEndpoints {
  login,
  loginJWT,
  getUser,
  updateUser,
}

enum EventsEndpoints {
  getEventById,
}

enum EventSessionsEndpoints {
  getEventById,
  user_agenda,
  user_agenda_add,
  user_agenda_delete
}
