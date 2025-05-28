// import 'package:deu_cis/product/constants/index.dart';
// import 'package:deu_cis/product/models/education.dart';
// import 'package:deu_cis/product/models/speaker.dart';
// import 'package:flutter/material.dart';

// class SpeakersDetailView extends StatefulWidget {
//   const SpeakersDetailView({super.key});

//   @override
//   State<SpeakersDetailView> createState() => _SpeakersDetailViewState();
// }

// class _SpeakersDetailViewState extends State<SpeakersDetailView> {
//   Speaker speaker = Speaker(
//     id: "1",
//     name: "John Doe",
//     email: "johndoe@gmail.com",
//     phoneNumber: "1234567890",
//     imageUrl: "https://picsum.photos/200/300",
//     title: "Doç. Dr.",
//     bio: "A brief description about the speaker.",
//     affillations: "English Street Blvd, New York, NY 10001",
//     education: [
//       Education(
//         id: "1",
//         name: "Computer Science",
//         university: "University of Example",
//         degree: "Master",
//         department: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//         startDate: DateTime(2010, 1, 1).toString(),
//         endDate: DateTime(2014, 1, 1).toString(),
//       ),
//       Education(
//         id: "2",
//         name: "Software Engineering",
//         degree: "PhD",
//         department: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//         university: "University of Example",
//         startDate: DateTime(2014, 1, 1).toString(),
//         endDate: DateTime(2018, 1, 1).toString(),
//       ),
//     ],
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "${speaker.title} ${speaker.name}",
//           style: AppTextStyles.titleTextWhite,
//         ),
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
//       ),
//       body: ListView(
//         children: [
//           Stack(
//             children: [
//               Positioned.fill(
//                 child: Container(
//                   foregroundDecoration: BoxDecoration(
//                     color: AppColors.textFieldTextColor.withOpacity(0.25),
//                     backgroundBlendMode: BlendMode.multiply,
//                   ),
//                   decoration: BoxDecoration(
//                       backgroundBlendMode: BlendMode.multiply,
//                       gradient: LinearGradient(colors: [
//                         AppColors.gradientFirst,
//                         AppColors.gradientSecond,
//                         AppColors.gradientThird
//                       ])),
//                 ),
//               ),
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Container(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             child: Column(
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: AppColors.white, width: 1),
//                                       shape: BoxShape.circle),
//                                   child: CircleAvatar(
//                                     radius: 50,
//                                     backgroundImage:
//                                         NetworkImage(speaker.imageUrl),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 5,
//                                 ),
//                                 Container(
//                                   decoration:
//                                       BoxDecoration(color: AppColors.blue),
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(10, 2, 10, 2),
//                                     child: Text(
//                                       StringConsts.speaker,
//                                       style: AppTextStyles.textFieldTextWhite,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Container(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   speaker.name,
//                                   style: AppTextStyles.titleTextWhite,
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     speaker.affillations,
//                                     style: AppTextStyles.subTitleText,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.star_border_outlined,
//                             color: AppColors.white,
//                           )),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Icon(Icons.chat_bubble_outline,
//                               color: AppColors.white)),
//                       IconButton(
//                           onPressed: () {},
//                           icon:
//                               Icon(Icons.mail_outline, color: AppColors.white))
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
