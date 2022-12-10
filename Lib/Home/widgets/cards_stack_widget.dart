import 'package:flutter/material.dart';
import '../../Resources/dimen.dart';
import '../../Utils/music_utils.dart';
import '../API/Requests/get_songs_list.dart';
import '../API/Requests/post_song_feedback.dart';
import '../API/Response_Objects/song_object.dart';
import '../Utils/swipe_enumerator.dart';
import 'drag_widget.dart';
import 'action_button_widget.dart';

class CardsStackWidget extends StatefulWidget {
  const CardsStackWidget({Key? key}) : super(key: key);

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
  static int startStackSize = 2;
}

class _CardsStackWidgetState extends State<CardsStackWidget> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late List<SongObject> draggableItems = [];
  late final MusicUtils _musicUtils;
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;

  void getInitialRecs() async{
    for(int i = 0; i < CardsStackWidget.startStackSize; i++) {
      try {
        SongObject rec = await getInitialSongRecommendations();
        draggableItems.insert(0, rec);
      } catch (e){
        break;
      }
    }
    if(draggableItems.isNotEmpty) {
      playSong(draggableItems.last);
    }
    setState(() {
      draggableItems;
    });
  }

  void getNewRec(int songId, bool like) async {
    SongObject newRec = await postSongFeedback(songId, like);
    draggableItems.insert(0, newRec);
  }

  void playSong(SongObject songObject) async {
    await _musicUtils.setUrl(songObject.songUrl);
    _musicUtils.play(songObject.start, songObject.end);
  }

  @override
  void initState() {
    super.initState();
    _musicUtils = MusicUtils();
    WidgetsBinding.instance.addObserver(this);
    getInitialRecs();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status)  {
      if (status == AnimationStatus.completed) {
        draggableItems.removeLast();
        _animationController.reset();
        _musicUtils.pause();
        bool like = swipeNotifier.value == Swipe.right ? true : false;
        getNewRec(draggableItems.last.songId, like);
        swipeNotifier.value = Swipe.none;

        if (draggableItems.isNotEmpty) {
          playSong(draggableItems.last);
        }

        setState(() {
          draggableItems;
        });
      }
    });
  }


  @override
  void dispose() {
    _musicUtils.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
    return Builder(
        builder: (BuildContext context) {
          if (draggableItems.isEmpty) {
            return const Center(
                child: SizedBox(
                  width: SongSnippetDimen.musicCardWidth,
                  height: SongSnippetDimen.musicCardWidth,
                  child: CircularProgressIndicator(),
                )
            );
          } else {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ValueListenableBuilder(
                    valueListenable: swipeNotifier,
                    builder: (context, swipe, _) => Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: List.generate(draggableItems.length, (index) {
                        if (index == draggableItems.length - 1) {
                          return PositionedTransition(
                            rect: RelativeRectTween(
                              begin: RelativeRect.fromSize(
                                  const Rect.fromLTWH(0, 0, 580, 340),
                                  const Size(580, 340)),
                              end: RelativeRect.fromSize(
                                  Rect.fromLTWH(
                                      swipe != Swipe.none
                                          ? swipe == Swipe.left
                                          ? -300
                                          : 300
                                          : 0,
                                      0,
                                      580,
                                      340),
                                  const Size(580, 340)),
                            ).animate(CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.easeInOut,
                            )),
                            child: RotationTransition(
                              turns: Tween<double>(
                                  begin: 0,
                                  end: swipe != Swipe.none
                                      ? swipe == Swipe.left
                                      ? -0.1 * 0.3
                                      : 0.1 * 0.3
                                      : 0.0)
                                  .animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve:
                                  const Interval(0, 0.4, curve: Curves.easeInOut),
                                ),
                              ),
                              child: DragWidget(
                                songObject: draggableItems[index],
                                index: index,
                                swipeNotifier: swipeNotifier,
                                isLastCard: true,
                              ),
                            ),
                          );
                        } else {
                          return DragWidget(
                            songObject: draggableItems[index],
                            index: index,
                            swipeNotifier: swipeNotifier,
                          );
                        }
                      }),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 46.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButtonWidget(
                          onPressed: () {
                            swipeNotifier.value = Swipe.left;
                            _animationController.forward();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ActionButtonWidget(
                          onPressed: () {
                            swipeNotifier.value = Swipe.right;
                            _animationController.forward();
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: DragTarget<int>(
                    builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                        ) {
                      return IgnorePointer(
                        child: Container(
                          height: 700.0,
                          width: 80.0,
                          color: Colors.transparent,
                        ),
                      );
                    },
                    onAccept: (int index) {
                      setState(() {
                        draggableItems.removeAt(index);
                      });
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  child: DragTarget<int>(
                    builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                        ) {
                      return IgnorePointer(
                        child: Container(
                          height: 700.0,
                          width: 80.0,
                          color: Colors.transparent,
                        ),
                      );
                    },
                    onAccept: (int index) {
                      setState(() {
                        draggableItems.removeAt(index);
                      });
                    },
                  ),
                ),
              ],
            );
          }
        }
    );
  }
}
