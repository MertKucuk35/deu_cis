// import 'package:apartura/product/models/apartment_user.dart';
// import 'package:apartura/product/models/fcm_notification.dart';
// import 'package:apartura/product/services/firebase/firebase_messaging_service.dart';
// import 'package:apartura/product/utils/exceptions/error_exceptions.dart';

// abstract class IFcmNotificationService {
//   Future<void> sendUserRegisterNotification(
//       UserRegisterNotification notification);
//   Future<void> sendIndividualBillsInfoNotification(
//       IndividualBillsInfoNotification notification);
//   Future<void> sendApartmentBillInfoNotification(
//       List<ApartmentUser>? tenants, ApartmentBillInfoNotification notification);
// }

// class FcmNotificationService implements IFcmNotificationService {
//   @override
//   Future<void> sendUserRegisterNotification(
//       UserRegisterNotification notification) async {
//     try {
//       await FirebaseNotificationService.sendNotification(
//           notification.refinedNotification());
//     } catch (e) {
//       ErrorExceptions.printError(e);
//     }
//   }

//   @override
//   Future<void> sendApartmentBillInfoNotification(List<ApartmentUser>? tenants,
//       ApartmentBillInfoNotification notification) async {
//     try {
//       if (tenants != null) {
//         {
//           for (int i = 0; i < tenants.length; i++) {
//             await FirebaseNotificationService.sendNotification(
//                 ApartmentBillInfoNotification(
//                         token: tenants[i].fcmToken,
//                         featureType: notification.featureType,
//                         billStatus: notification.billStatus)
//                     .refinedNotification());
//           }
//         }
//       }
//     } catch (e) {
//       ErrorExceptions.printError(e);
//     }
//   }

//   @override
//   Future<void> sendIndividualBillsInfoNotification(
//       IndividualBillsInfoNotification notification) async {
//     try {
//       await FirebaseNotificationService.sendNotification(
//           notification.refinedNotification());
//     } catch (e) {
//       ErrorExceptions.printError(e);
//     }
//   }
// }
