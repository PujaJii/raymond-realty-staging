import 'package:get/get.dart';
import '../../ui/pages.dart';


class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/signUp', page: () => const SignUp()),
    GetPage(name: '/userSelect', page: () => const UserSelectPage()),
    GetPage(name: '/bottomNavPage', page: () =>  BottomNavPage(index: 0,)),
    GetPage(name: '/generateLeads', page: () => const GenerateLeads()),
    GetPage(name: '/leadsPage', page: () => const LeadsPage()),
    GetPage(name: '/siteVisitPage', page: () => const SiteVisitPage()),
    GetPage(name: '/bookinsPage', page: () => const BookinsPage()),
    // GetPage(name: '/projectDetailPage', page: () => const ProjectDetailPage()),
    GetPage(name: '/thankYouPage', page: () =>  ThankYouPage( msg: 'Thank You', index: 0,),),
    GetPage(name: '/chooseSignUp', page: () => const ChooseSignUp(),),
    //GetPage(name: '/drawerPage', page: () => const DrawerPage(),),
    GetPage(name: '/forgotPasswordMail', page: () => const ForgotPasswordMail(),),
    GetPage(name: '/forgotPasswordPhone', page: () => const ForgotPasswordPhone(),),

    ///CP PAGES
    GetPage(name: '/cpLogIN', page: () => const CPLoginPage(),),
    GetPage(name: '/cpBottomNav', page: () => const CPBottomNavPage(index: 0,),),
    //GetPage(name: '/projectDetailPageCP', page: () => const ProjectDetailPageCP(),),
  ];
}
