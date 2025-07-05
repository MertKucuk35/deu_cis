// ignore_for_file: public_member_api_docs, sort_constructors_first
// teke tek manager-tenant   tenant-manager    1.katılma isteği 2. sayaç bilgi girimi 3. dekont bilgi girimi 4. fatura-dekont onaylanması
// tekten çoka  manager-apartmernt    1.fatura oluşturuldu 2. fatura pay edildi 3. fatura ödendi

//Teke-tek Yönetici-Apartman sakini
//1. katılım isteği (yöneticiye giden-onay-red) bildirimi
//2. sayaç bilgi girimi (apartman sakinine giden-onay-red)
//3. dekont bilgi girimi (apartman sakinine giden-onay-red)

//Tekten-Çoka Yönetici-Apartman
//1. fatura oluşturuldu (apartman sakinine giden)
//2. fatura pay edildi (apartman sakinine giden)
//3. fatura ödendi (apartman sakinine giden)

abstract class FcmNotification {
  String? title;
  String? message;
  String? token;

  FcmNotification({
    this.title,
    this.message,
    required this.token,
  });

  FcmNotification refinedNotification();
}

// class UserRegisterNotification extends FcmNotification {
//   bool isManagerResponse;
//   bool? isAccepted;
//   String apartmentName;
//   String candidateName;
//   UserRegisterNotification({
//     super.title,
//     super.message,
//     required super.token,
//     required this.isManagerResponse,
//     required this.apartmentName,
//     required this.candidateName,
//   });

//   @override
//   UserRegisterNotification refinedNotification() {
//     if (isManagerResponse) {
//       title = 'Katılım İsteği Cevabı';
//       message =
//           '$apartmentName apartmanına katılma isteğiniz ${isAccepted! ? 'kabul edildi' : 'reddedildi'}';
//     } else {
//       title = 'Katılım İsteği';
//       message =
//           '$candidateName $apartmentName apartmanına katılma isteği gönderdi.';
//     }
//     return this;
//   }

//   // $apartmentUser.name $apartmen.name'na katılma isteği gönderdi.
//   // $aparment.name'na katılma isteğiniz $isaccepted ? 'kabul edildi' : 'reddedildi'
// }

// class IndividualBillsInfoNotification extends FcmNotification {
//   String featureType;
//   BillStatus billStatus;
//   bool isManagerResponse;
//   bool? isAccepted;
//   ApartmentUser? tenant;
//   IndividualBillsInfoNotification(
//       {super.title,
//       super.message,
//       required super.token,
//       required this.featureType,
//       required this.billStatus,
//       required this.isManagerResponse,
//       this.tenant,
//       this.isAccepted});

//   IndividualBillsInfoNotification copyWith(
//     String? title,
//     String? message,
//     String? token,
//   ) {
//     return IndividualBillsInfoNotification(
//       title: title ?? this.title,
//       message: message ?? this.message,
//       token: token ?? this.token,
//       featureType: featureType,
//       billStatus: billStatus,
//       isManagerResponse: isManagerResponse,
//       isAccepted: isAccepted,
//       tenant: tenant,
//     );
//   }

//   @override
//   IndividualBillsInfoNotification refinedNotification() {
//     if (isManagerResponse) {
//       title = 'Fatura Bilgisi Cevabı';
//       message =
//           'Yönetici ${featureType} faturası  ${billStatus == BillStatus.collectingBill ? 'sayaç' : 'dekont'} bilginizi ${isAccepted! ? 'onayladı' : 'reddetti'}.';
//     } else {
//       title = 'Apartman Sakini Fatura Bilgisi';
//       message =
//           '${tenant?.name} ${featureType} faturası ${billStatus == BillStatus.collectingBill ? 'sayaç' : 'dekont'} bilgisini girdi.';
//     }
//     return this;
//   }

//   //$aparmentuser.name $featuretype faturası $isCounter ? 'sayaç' : 'dekont' bilgisini girdi.
//   //Yönetici $isCounter ? 'sayaç' : 'dekont' bilginizi $is accepted ? onayladı : reddetti.
// }

// class ApartmentBillInfoNotification extends FcmNotification {
//   String featureType;
//   BillStatus billStatus;
//   ApartmentBillInfoNotification(
//       {super.title,
//       super.message,
//       super.token,
//       required this.featureType,
//       required this.billStatus});

//   @override
//   ApartmentBillInfoNotification refinedNotification() {
//     if (billStatus == BillStatus.collectingBill) {
//       title = 'Fatura Oluşturuldu';
//       message =
//           'Yönetici $featureType faturası oluşturdu. Sayaç bilginizi girin';
//     } else if (billStatus == BillStatus.collectingReceipt) {
//       title = 'Fatura Pay Edildi';
//       message =
//           'Yönetici $featureType faturasını pay etti. Dekont bilginizi girin';
//     } else {
//       title = 'Fatura Ödendi';
//       message = 'Yönetici $featureType faturasını ödedi.';
//     }

//     return this;
//   }
//   //Yönetici yeni $featuretype faturası oluşturdu.
//   //Yönetici $featuretype faturasını pay etti.
//   //Yönetici $featuretype faturasını ödedi.
// }
