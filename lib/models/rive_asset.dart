import 'package:rive/rive.dart';
class RiveAsset {
  final String artboard,stateMachineName, title, src;
  late SMIBool? input;
  RiveAsset(this.src,
  {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input
  });

  set setInput(SMIBool status){
    input = status;
  }

}

List<RiveAsset> sideMenus = [
  RiveAsset
  ("assets/images/home_logo.riv", 
  artboard: "HOME", 
  stateMachineName: "HOME_interactivity", 
  title: "Home"
  ),

  RiveAsset
  ("assets/images/history_logo.riv", 
  artboard: "TIMER", 
  stateMachineName: "TIMER_interactivity", 
  title: "Request History"
  ),

  RiveAsset
  ("assets/images/scplogo.riv", 
  artboard: "Board", 
  stateMachineName: "Board_interactivity", 
  title: "Driver Mode"
  ),

  RiveAsset
  ("assets/images/settings_logo.riv", 
  artboard: "SETTINGS", 
  stateMachineName: "SETTINGS_interactivity", 
  title: "Settings"
  ),

  RiveAsset
  ("assets/images/faq_logo.riv", 
  artboard: "CHAT", 
  stateMachineName: "CHAT_interactivity", 
  title: "FAQ"
  ),

];