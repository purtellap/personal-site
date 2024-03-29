import 'package:flutter/material.dart';

import '../portfolio/projects.dart';

class Dimens {
  static const double splashRadius = 24;
  static const double maxPortfolioWidth = 800;
  static const double portfolioMobileThreshold = 680;
  static const int sceneHeight = 512;
  static const int sceneWidth = 1536;
  static const int mobileView = 900;
  static const int mobileView2 = 600;
  static const int mobileLandscape = 420;

  static const int sunsetDuration = 80;

  static const int gradientDuration = 3; // 5
  static const int openingGradientsNum = 6;
  static const int totalGradientDuration =
      gradientDuration * openingGradientsNum;

  static const Widget sectionHeight = const SizedBox(height: 96);
  static const Widget subSectionHeight = const SizedBox(height: 32);
}

class ThemeColors {
  // Dark Theme
  static const Color backgroundColor = Colors.black;
  static const Color secondaryBackgroundColor = Color(0x0dfdfdff);
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Color(0x33ffffff);
  static const Color headerDescColor = Color(0x40e0e0ff);

  // Accent Colors
  static const List<Color> textGradients = [
    Color(0xff707CED),
    Color(0xffD470ED),
  ];
  static const List<Color> containerGradients = [
    Color(0xff0D0914),
    Color(0xff090F1F),
  ];
  static const List<Color> freelanceGradients = [
    Color.fromARGB(255, 19, 15, 26),
    Color(0xaa090F1F),
  ];
  static const List<Color> openGradients = [
    Color(0x88003630),
    Color(0x6600710B),
  ];
  static const Color highlightGradientColor =
      Color.fromARGB(255, 255, 173, 244);
}

class Strings {
  static const String title = 'Austin\'s Site';
  static const String portfolioTitle = 'Austin Purtell\'s Portfolio';
  static const String resumeLink =
      'https://drive.google.com/file/d/1Jlgmg_8CfhOHr--oCupWvxPYTot_T3Yl/view?usp=share_link';
  static const String designPortfolioLink =
      'https://www.figma.com/file/PhBEpLOSAOL3HMv0tFFloH/Design-Portfolio?type=design&node-id=0%3A1&mode=design&t=ciYByAbrRVa9i1DO-1';

  static const String email = 'mailto:purtellap@gmail.com';
  static const String github = 'https://github.com/purtellap';
  static const String linkedin = 'https://www.linkedin.com/in/austin-purtell/';
  static const String instagram = 'https://www.instagram.com/austinpurtell';
  static const String youtube = 'https://www.youtube.com/@asutin';

  // Dialogue
  static const String talk = '[ talk ]';
  static const String ask = '[ ask ]';

  static const String end1 = 'You\'re very patient.';
  static const String end2 = 'Thanks for checking out my website.';

  static List<String> talks = [
    'Hello.',
    'Ah, to be free...',
    '\"Be a philosopher; but, amidst all your philosophy, be still a man.\"',
    'Enough about me, how about you?',
    'One day I want to live on a boat.',
    'Don\'t take life so seriously.',
    'I was a collegiate level rocket league player for a time.',
    'Almost there...',
    'It\'s peaceful out here.',
    'Good skimboarding down there...',
    'Whitewater rafting is an intense summer job.',
  ]..shuffle();

  static const List<String> questions = [
    'Who are you?',
    'Interests?',
    'Life Goals?',
  ];

  static const List<String> answers = [
    'Not sure. But I\'d like to learn.',
    'Outdoors, Crypto, Astronomy, Gaming, Youtube...',
    'Explore the world, help the environment, have fun.',
  ];

  // Portfolio
  static const String projectsTitle = 'Projects';
  static const String projectsQuote =
      '"Where the spirit does not work with the hand, there is no art."\n- Leonardo da Vinci';
  static const String project2Name = 'Other stuff';
  static const String project2Description = 'Description';
  static const String flutter = 'Flutter';
  static const String java = 'Java';
  static const String unity = 'Unity';

  static const String designsTitle = 'Designs';
  static const String designsQuote =
      '"Art does not reproduce the visible; rather, it makes visible."\n- Paul Klee';
  static const String designName = 'My Design Portfolio';
  static const String designDescription = 'A showcase';

  static const String contactTitle = 'Contact';
  static const String contactQuote =
      '"Service to others is the rent you pay for your room here on Earth."\n- Muhammad Ali';
  static const String freelanceOpportunities =
      'For freelance opportunities in:';
  static const String status = 'Status';
  static const String statusOpen = 'OPEN';
  static const String statusClosed = 'CLOSED';
  static const String frontendDevelopment = 'Frontend Development';
  static const String uiuxDesign = 'UI/UX Design';
  static const String webDevelopment = 'Web development';
  static const String technicalConsulting = 'Technical Consulting';
  static const String nameField = 'Name';
  static const String emailField = 'Email';
  static const String messageField = 'Message';
  static const String sendButton = 'Send';
  static const String requiredFields = 'Please fill out the required fields';
  static const String errorSending = 'There was an error sending your message';
  static const String waitSending =
      'Please wait 5 minutes before sending another message';
  static const String successSending =
      'Message sent, thanks for reaching out :)';
}

class Images {
  static const Image ocean = Image(
      image: AssetImage('assets/images/ocean.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image sun = Image(
      image: AssetImage('assets/images/sun.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image cliff = Image(
      image: AssetImage('assets/images/cliff.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image paper = Image(
      image: AssetImage('assets/images/paper.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);
  static const Image moon = Image(
      image: AssetImage('assets/images/moon.gif'),
      filterQuality: FilterQuality.none,
      isAntiAlias: false);

  static const String figma =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Figma-logo.svg/1667px-Figma-logo.svg.png';

  // Portfolio
  static const String astronaut = 'assets/images/astronaut.png';
  static const String ssLogo = 'assets/images/sslogo.png';
  static const String imcLogo = 'assets/images/imc.png';
  static const String wfLogo = 'assets/images/wf.png';
  static const String floppyLogo = 'assets/images/floppy.png';
  static const String design = 'assets/images/design.png';

  // Socials
  static const String youtube = 'assets/icons/youtube.png';
  static const String instagram = 'assets/icons/instagram.png';
  static const String linkedin = 'assets/icons/linkedin.png';
  static const String github = 'assets/icons/github.png';

  static const List<AssetImage> portfolioImages = [
    AssetImage(astronaut),
    AssetImage(ssLogo),
    AssetImage(imcLogo),
    AssetImage(wfLogo),
    AssetImage(floppyLogo),
    AssetImage(design),
    AssetImage(youtube),
    AssetImage(instagram),
    AssetImage(linkedin),
    AssetImage(github),
  ];
}

class TextStyles {
  static const TextStyle dialog = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontFamily: 'retro',
      letterSpacing: .8,
      fontWeight: FontWeight.w100);

  static const TextStyle portfolio = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'inter',
  );

  static const TextStyle portfolio2 = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'inter',
    letterSpacing: 1,
  );
}

class Projects {
  static final List<Widget> projects = [
    imc,
    scalpSetter,
    wallpaperFactory,
    floppyBirb,
  ];
  static Widget scalpSetter = ProjectWidget(
    iconUrl: Images.ssLogo,
    previewUrl:
        'https://play-lh.googleusercontent.com/jZ3tSfe_ZLa-JbCCQosqnHB9INWIy86WakpcSvnEkMfCD0tOvsgzGpv6_wy71XADwn8K=w832-h470-rw',
    language: Strings.flutter,
    title: 'scalpsetter.com',
    description: 'Risk management calculator tool',
    downloads: '50+',
    rating: null,
    onPressedUrl: 'https://www.scalpsetter.com',
    onGithubUrl: 'https://github.com/purtellap/ScalpSetter',
    onStoreUrl:
        'https://play.google.com/store/apps/details?id=com.austinpurtell.scalpsetter',
  );
  static Widget imc = ProjectWidget(
    iconUrl: Images.imcLogo,
    previewUrl:
        'https://firebasestorage.googleapis.com/v0/b/personal-site-8ebf9.appspot.com/o/imc_banner.png?alt=media&token=b70a6f27-4374-4137-9fb4-5061d6c3df0d',
    language: Strings.flutter,
    title: 'Intergalactic Mining Co.',
    description: 'Blockchain game',
    downloads: null,
    rating: null,
    onPressedUrl: 'https://intergalacticmining.co/game',
    onGithubUrl: '',
    onStoreUrl: 'https://intergalacticmining.co/game',
  );
  static Widget wallpaperFactory = ProjectWidget(
    iconUrl: Images.wfLogo,
    previewUrl:
        'https://firebasestorage.googleapis.com/v0/b/personal-site-8ebf9.appspot.com/o/wf_banner.png?alt=media&token=96937dec-e669-4c5a-a247-a3c133345208',
    language: Strings.java,
    cover: true,
    title: 'Wallpaper Factory',
    description: 'Android live wallpaper app',
    downloads: '1000+',
    rating: '3.2',
    onPressedUrl:
        'https://play.google.com/store/apps/details?id=com.austinpurtell.wf',
    onGithubUrl: 'https://github.com/purtellap/Wallpaper-Factory',
    onStoreUrl:
        'https://play.google.com/store/apps/details?id=com.austinpurtell.wf',
  );
  static Widget floppyBirb = ProjectWidget(
    iconUrl: Images.floppyLogo,
    previewUrl:
        'https://play-lh.googleusercontent.com/AY6Z-62TIhzS5FNcTFeRWHB0MT2RTIaJNXhaieKXZxvIr1t6oTl7-g7JlNZKVPS7Yw=w832-h470-rw',
    cover: true,
    language: Strings.unity,
    title: 'Floppy Birb',
    description: 'Revolutionary mobile game',
    downloads: '200+',
    rating: '4.6',
    onPressedUrl:
        'https://play.google.com/store/apps/details?id=com.austinpurtell.floppybirb',
    onGithubUrl: '',
    onStoreUrl:
        'https://play.google.com/store/apps/details?id=com.austinpurtell.floppybirb',
  );
}

extension DimensExtension on BuildContext {
  bool get isMobileWidth =>
      MediaQuery.of(this).size.width < Dimens.portfolioMobileThreshold;
}
