import 'package:flutter/material.dart';
import '../API/Response_Objects/song_object.dart';

class MusicCard extends StatelessWidget {
  const MusicCard({Key? key, required this.songObject}) : super(key: key);
  final SongObject songObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 580,
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                songObject.imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 80,
              width: 340,
              decoration: ShapeDecoration(
                color:Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: <BoxShadow>[
                  BoxShadow(
                    color:Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      songObject.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 21,
                      ),
                    ),
                    Text(
                      "${songObject.start} to ${songObject.end} second marks",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}