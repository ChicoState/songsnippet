import 'package:flutter/material.dart';
import '../Home/API/Response_Objects/song_object.dart';
import '../Home/home_view_model.dart';
import '../Resources/dimen.dart';
import '../Resources/strings.dart';
import '../main.dart';
import '../Home/API/Requests/get_songs_list.dart';
import '../Home/API/Response_Objects/song_list_object.dart';
import 'drag_widget.dart';
import 'action_button_widget.dart';
import '../Home/API/Requests/post_song_feedback.dart';
import '../Utils/music_utils.dart';


class CardsStackWidget extends StatefulWidget {
  const CardsStackWidget({Key? key}) : super(key: key);

  @override
  State<CardsStackWidget> createState() => _CardsStackWidgetState();
}

class _CardsStackWidgetState extends State<CardsStackWidget>
    with SingleTickerProviderStateMixin {
  late final MusicUtils _musicUtils;
  late HomeViewModel homeViewModel = HomeViewModel();

  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _musicUtils = MusicUtils();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();

        swipeNotifier.value = Swipe.none;
      }
    });
  }

  @override
  void dispose() {
    _musicUtils.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: homeViewModel.songList,
        builder: (BuildContext context, AsyncSnapshot<SongList> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text(SongSnippetStrings.error),);
            } else {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ValueListenableBuilder(
                      valueListenable: swipeNotifier,
                      builder: (context, swipe, _) =>
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: List.generate(
                                snapshot.data!.songList.length, (index) {
                              if (index == snapshot.data!.songList.length - 1) {
                                _musicUtils.setUrl('${snapshot.data!.songList.elementAt(index)?.songUrl}');
                                _musicUtils.play(snapshot.data!.songList.elementAt(index)!.start, snapshot.data!.songList.elementAt(index).end);
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
                                        const Interval(
                                            0, 0.4, curve: Curves.easeInOut),
                                      ),
                                    ),
                                    child: DragWidget(
                                      song: snapshot.data!.songList.elementAt(index),
                                      index: index,
                                      swipeNotifier: swipeNotifier,
                                      isLastCard: true,
                                    ),
                                  ),
                                );
                              } else {
                                return DragWidget(
                                  song: snapshot.data!.songList.elementAt(index),
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
                              postSongFeedback(3, true);
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
                      builder: (BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,) {
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
                          snapshot.data!.songList.removeAt(index);
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: DragTarget<int>(
                      builder: (BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,) {
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
                          snapshot.data!.songList.removeAt(index);
                        });
                      },
                    ),
                  ),
                ],
              );
            }
          }
          return const Center(
              child: SizedBox(
                width: SongSnippetDimen.padding8x,
                height: SongSnippetDimen.padding8x,
                child: CircularProgressIndicator(),
              )
          );
        }
    );
  }
}

