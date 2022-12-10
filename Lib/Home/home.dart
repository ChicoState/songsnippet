import 'package:flutter/cupertino.dart';
import 'widgets/cards_stack_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

<<<<<<< HEAD
class _HomeState extends State<Home> with WidgetsBindingObserver{
  late final MusicUtils _musicUtils;

  //Lazy initialized
  late HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _musicUtils = MusicUtils();
  }

  @override
  void dispose() {
    _musicUtils.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

=======
class _HomeState extends State<Home> {
>>>>>>> 03bd0f57e49d02088455d1e08df93edf0293a2d3
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // there are 4 states: Resumed, Inactive, Paused, and Detatched
    // resumed state is when the app comes back to the foreground, but not when first initialized
    // inactive is when the app is out of focus, for example a dialog box pops up
    // paused is when the app is fully in the background
    // detached is when the app is closed

    if (state == AppLifecycleState.inactive) return;

    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _musicUtils.pause();
    }

  }

  @override
  Widget build(BuildContext context) {
    return const CardsStackWidget();
  }
}
