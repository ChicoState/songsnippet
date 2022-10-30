import '../Home/API/Requests/get_songs_list.dart';
import '../Home/API/Response_Objects/song_list_object.dart';

class HomeViewModel {
  late Future<SongList> songList;

  HomeViewModel() {
    songList = getSongList();
  }
}