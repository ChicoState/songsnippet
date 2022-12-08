import 'package:flutter/material.dart';
import '../main.dart';
import '../resources/dimen.dart';
import '../resources/strings.dart';
import 'music_card.dart';
import 'tag_widget.dart';
import '../Home/API/Response_Objects/song_object.dart';


class DragWidget extends StatefulWidget {
  const DragWidget({
    Key? key,
    required this.songObject,
    required this.index,
    required this.swipeNotifier,
    required this.idNotifier,
    this.isLastCard = false,
  }) : super(key: key);
  final Future<SongObject> songObject;
  final int index;
  final ValueNotifier<Swipe> swipeNotifier;
  final ValueNotifier<int> idNotifier;
  final bool isLastCard;

  @override
  State<DragWidget> createState() => _DragWidgetState();
}

class _DragWidgetState extends State<DragWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.songObject,
      builder: (BuildContext context, AsyncSnapshot<SongObject> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text(SongSnippetStrings.error),);
          } else {
            widget.idNotifier.value = snapshot.requireData.songId;
            return Center(
              child: Draggable<int>(
                // Data is the value this Draggable stores.
                data: widget.index,
                feedback: Material(
                  color: Colors.transparent,
                  child: ValueListenableBuilder(
                    valueListenable: widget.swipeNotifier,
                    builder: (context, swipe, _) {
                      return RotationTransition(
                        turns: widget.swipeNotifier.value != Swipe.none
                            ? widget.swipeNotifier.value == Swipe.left
                            ? const AlwaysStoppedAnimation(-15 / 360)
                            : const AlwaysStoppedAnimation(15 / 360)
                            : const AlwaysStoppedAnimation(0),
                        child: Stack(
                          children: [
                            MusicCard(songObject: snapshot.requireData),
                            widget.swipeNotifier.value != Swipe.none
                                ? widget.swipeNotifier.value == Swipe.right
                                ? Positioned(
                              top: 40,
                              left: 20,
                              child: Transform.rotate(
                                angle: 12,
                                child: TagWidget(
                                  text: 'LIKE',
                                  color: Colors.green[400]!,
                                ),
                              ),
                            )
                                : Positioned(
                              top: 50,
                              right: 24,
                              child: Transform.rotate(
                                angle: -12,
                                child: TagWidget(
                                  text: 'DISLIKE',
                                  color: Colors.red[400]!,
                                ),
                              ),
                            )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                onDragUpdate: (DragUpdateDetails dragUpdateDetails) {
                  if (dragUpdateDetails.delta.dx > 0 &&
                      dragUpdateDetails.globalPosition.dx >
                          MediaQuery
                              .of(context)
                              .size
                              .width / 2) {
                    widget.swipeNotifier.value = Swipe.right;
                  }
                  if (dragUpdateDetails.delta.dx < 0 &&
                      dragUpdateDetails.globalPosition.dx <
                          MediaQuery
                              .of(context)
                              .size
                              .width / 2) {
                    widget.swipeNotifier.value = Swipe.left;
                  }
                },
                onDragEnd: (drag) {
                  widget.swipeNotifier.value = Swipe.none;
                },

                childWhenDragging: Container(
                  color: Colors.transparent,
                ),

                //This will be visible when we press action button
                child: ValueListenableBuilder(
                    valueListenable: widget.swipeNotifier,
                    builder: (BuildContext context, Swipe swipe,
                        Widget? child) {
                      return Stack(
                        children: [
                          MusicCard(songObject: snapshot.requireData),
                          // heck if this is the last card and Swipe is not equal to Swipe.none
                          swipe != Swipe.none && widget.isLastCard
                              ? swipe == Swipe.right
                              ? Positioned(
                            top: 40,
                            left: 20,
                            child: Transform.rotate(
                              angle: 12,
                              child: TagWidget(
                                text: 'LIKE',
                                color: Colors.green[400]!,
                              ),
                            ),
                          )
                              : Positioned(
                            top: 50,
                            right: 24,
                            child: Transform.rotate(
                              angle: -12,
                              child: TagWidget(
                                text: 'DISLIKE',
                                color: Colors.red[400]!,
                              ),
                            ),
                          )
                              : const SizedBox.shrink(),
                        ],
                      );
                    }),
              ),
            );
          }
        } else {
          return const Center(
              child: SizedBox(
                width: SongSnippetDimen.padding8x,
                height: SongSnippetDimen.padding8x,
                child: CircularProgressIndicator(),
              )
          );
        }
      },
    );
  }
}