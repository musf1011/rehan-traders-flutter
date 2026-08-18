// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class WhatsappButton extends StatelessWidget {
// //   const WhatsappButton({super.key});

// //   Future<void> _launchWhatsApp(BuildContext context) async {
// //     // Format: Country code without '+' or spaces
// //     String phoneNumber = "923143094341";

// //     // URL for web WhatsApp
// //     String webWhatsappUrl = "https://web.whatsapp.com/send?phone=$phoneNumber";

// //     // URL for app (wa.me redirects to app if installed)
// //     String appWhatsappUrl = "https://wa.me/$phoneNumber";

// //     final Uri appUri = Uri.parse(appWhatsappUrl);
// //     final Uri webUri = Uri.parse(webWhatsappUrl);

// //     try {
// //       // First try: Check if WhatsApp app can be opened
// //       if (await canLaunchUrl(appUri)) {
// //         await launchUrl(
// //           appUri,
// //           mode: LaunchMode.externalApplication, // Opens in WhatsApp app
// //         );
// //       }
// //       // Second try: If app not available, open in browser (web.whatsapp.com)
// //       else if (await canLaunchUrl(webUri)) {
// //         await launchUrl(
// //           webUri,
// //           mode: LaunchMode.platformDefault, // Opens in default browser
// //         );
// //       } else {
// //         throw 'Could not launch WhatsApp on any platform';
// //       }
// //     } catch (e) {
// //       if (context.mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text(
// //               'Could not open WhatsApp. Please check your internet connection.',
// //             ),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return IconButton(
// //       onPressed: () => _launchWhatsApp(context),
// //       icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

// class WhatsappButton extends StatelessWidget {
//   const WhatsappButton({super.key});

//   Future<void> _launchWhatsApp(BuildContext context) async {
//     // Format: Country code without '+' or spaces
//     String phoneNumber = "923143094341";

//     // ALWAYS use web.whatsapp.com for web testing
//     // This works on both desktop browsers AND mobile browsers
//     // String whatsappUrl = "https://web.whatsapp.com/send?phone=$phoneNumber";
//     String whatsappUrl = "https://wa.me/923143094341";

//     final Uri url = Uri.parse(whatsappUrl);

//     try {
//       if (await canLaunchUrl(url)) {
//         await launchUrl(
//           url,
//           mode: LaunchMode.platformDefault, // Opens in browser
//         );
//       } else {
//         throw 'Could not launch URL';
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text(
//               'Could not open WhatsApp. Please check your internet connection.',
//             ),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () => _launchWhatsApp(context),
//       icon: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rehan_trader_website/core/constants/app_constants.dart';
import 'package:rehan_trader_website/core/utils/url_launcher_helper.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key});

  // // WhatsApp function
  // Future<void> _launchWhatsApp(BuildContext context) async {
  //   String phoneNumber = "923143094341";
  //   String whatsappUrl = "https://web.whatsapp.com/send?phone=$phoneNumber";
  //   final Uri url = Uri.parse(whatsappUrl);

  //   try {
  //     if (await canLaunchUrl(url)) {
  //       await launchUrl(url, mode: LaunchMode.platformDefault);
  //     } else {
  //       throw 'Could not launch URL';
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Could not open WhatsApp'),
  //           backgroundColor: AppConstants.errorColor,
  //         ),
  //       );
  //     }
  //   }
  // }

  // // Instagram function
  // Future<void> _launchInstagram(BuildContext context) async {
  //   String instagramUrl = "https://www.instagram.com/famzycodeworks/";
  //   final Uri url = Uri.parse(instagramUrl);

  //   try {
  //     if (await canLaunchUrl(url)) {
  //       await launchUrl(url, mode: LaunchMode.platformDefault);
  //     } else {
  //       throw 'Could not launch URL';
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Could not open Instagram'),
  //           backgroundColor: AppConstants.errorColor,
  //         ),
  //       );
  //     }
  //   }
  // }

  // // Twitter/X function
  // Future<void> _launchTwitter(BuildContext context) async {
  //   String twitterUrl = "https://x.com/92MUSF";
  //   final Uri url = Uri.parse(twitterUrl);

  //   try {
  //     if (await canLaunchUrl(url)) {
  //       await launchUrl(url, mode: LaunchMode.platformDefault);
  //     } else {
  //       throw 'Could not launch URL';
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Could not open Twitter/X'),
  //           backgroundColor: AppConstants.errorColor,
  //         ),
  //       );
  //     }
  //   }
  // }

  // // Facebook function
  // Future<void> _launchFacebook(BuildContext context) async {
  //   String facebookUrl = "https://www.facebook.com/Musf92";
  //   final Uri url = Uri.parse(facebookUrl);

  //   try {
  //     if (await canLaunchUrl(url)) {
  //       await launchUrl(url, mode: LaunchMode.platformDefault);
  //     } else {
  //       debugPrint('Could not launch URL facebook: $facebookUrl');
  //       throw 'Could not launch URL';
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Could not open Facebook'),
  //           backgroundColor: AppConstants.errorColor,
  //         ),
  //       );
  //     }
  //   }
  // }

  //whatsapp
  Future<void> _launchWhatsApp(BuildContext context) async {
    await UrlLauncherHelper.launchLink(
      context: context,
      url: 'https://wa.me/923143094341',
      errorMessage: 'Could not open WhatsApp',
    );
  }

  //instagram
  Future<void> _launchInstagram(BuildContext context) async {
    await UrlLauncherHelper.launchLink(
      context: context,
      url: 'https://www.instagram.com/famzycodeworks/',
      errorMessage: 'Could not open Instagram',
    );
  }

  //twitter/x
  Future<void> _launchTwitter(BuildContext context) async {
    await UrlLauncherHelper.launchLink(
      context: context,
      url: 'https://x.com/92MUSF',
      errorMessage: 'Could not open Twitter/X',
    );
  }

  //facebook
  Future<void> _launchFacebook(BuildContext context) async {
    // final BuildContext ctx = context;

    try {
      await UrlLauncherHelper.launchLink(
        context: context,
        url: 'https://www.facebook.com/Musf92',
        errorMessage: 'Could not open Facebook',
      );
    } catch (e) {
      if (!context.mounted) return;

      await UrlLauncherHelper.launchLink(
        context: context,
        url: '100029515020904',
        errorMessage: 'Could not open Facebook',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: .center,
      children: [
        // WhatsApp Button
        IconButton(
          onPressed: () => _launchWhatsApp(context),
          icon: FaIcon(
            FontAwesomeIcons.whatsapp,
            color: AppConstants.whatsappGreen,
            size: 28.h,
          ),
        ),
        SizedBox(width: 5.w),

        // Instagram Button
        IconButton(
          onPressed: () => _launchInstagram(context),
          icon: FaIcon(
            FontAwesomeIcons.instagram,
            color: AppConstants.instagramPink,
            size: 28.h,
          ),
        ),
        SizedBox(width: 5.w),

        // Twitter/X Button
        // GestureDetector(
        //   onTap: () => _launchTwitter(context),
        //   child: Container(
        //     margin: EdgeInsets.only(top: 4.h),
        //     padding: EdgeInsets.all(4.h),
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors
        //           .black, // Optional: Add a white background for better visibility
        //     ),
        // child: FaIcon(
        //   FontAwesomeIcons.xTwitter, // Updated for X/Twitter
        //   color: Colors.white, // Black (or use 0xFF1DA1F2 for old blue)
        //   size: 24.h,
        // ),
        //   ),
        // ),
        IconButton(
          onPressed: () => _launchTwitter(context),
          icon: FaIcon(
            FontAwesomeIcons.xTwitter, // Updated for X/Twitter
            color: Colors.white, // Black (or use 0xFF1DA1F2 for old blue)
            size: 28.h,
          ),
        ),
        SizedBox(width: 5.w),

        // Facebook Button
        IconButton(
          onPressed: () => _launchFacebook(context),
          icon: FaIcon(
            FontAwesomeIcons.facebook,
            color: AppConstants.facebookBlue, // Facebook Blue
            size: 28.h,
          ),
        ),
      ],
    );
  }
}
