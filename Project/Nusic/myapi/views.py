from rest_framework.decorators import api_view
from .serializers import SongModelSerializer
from .serializers import SongFeedbackSerializer
from .serializers import InitialSongRecommendationsSerializer
from .models import SongModel
from .models import FeedbackModel
from rest_framework.response import Response
from rest_framework import viewsets, status
import random


class SongViewSet(viewsets.ModelViewSet):
    queryset = SongModel.objects.all().order_by('artist')
    serializer_class = SongModelSerializer

#not sure if this works until we test
def RecommendSong(user,count):
    excluded_song_ids = FeedbackModel.objects.filter(creator = user.id).values('song')
    possible_songs = SongModel.objects.exclude(id__in=excluded_song_ids)
    random.shuffle(possible_songs)
    if len(possible_songs) == 0:
        return []
    if count > len(possible_songs):
        count = len(possible_songs)
    return possible_songs[0:count]


@api_view(['POST'])
def SongFeedback(request):
    songFeedbackSerializer = SongFeedbackSerializer(data=request.data)

    if songFeedbackSerializer.is_valid():

        prevLikeObject = SongFeedback.objects.filter(
            creator=request.user,
            song=songFeedbackSerializer.data['song']
        ).first()

        # if a like or dislike somehow exists, delete before creating a new one
        if prevLikeObject is not None:
            prevLikeObject.delete()

        SongFeedback.create(
            creator=request.user,
            song=request.data['song'],
            like=request.data['like']
        )


        recommendedSong = RecommendSong(request.user, 1)

        if recommendedSong == []:
            return Response(status=204)

        recSongSerializer = SongModelSerializer(recommendedSong[0])


        return Response(recSongSerializer.data, status=status.HTTP_201_CREATED)
    return Response(songFeedbackSerializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
#   {"count": 1}
def InitialSongRecommendations(request):
    initialSongRecommendationsSerializer = InitialSongRecommendationsSerializer(data=request.data)
    if initialSongRecommendationsSerializer.is_valid():
        recommendedSongs = RecommendSong(request.user, initialSongRecommendationsSerializer.data["count"])
        if recommendedSongs == []:
            return Response(status=204)

        recSongSerializer = SongModelSerializer(recommendedSongs, many=true)

        return Response(recSongSerializer.data, status=200)
    return Response(songFeedbackSerializer.errors, status=status.HTTP_400_BAD_REQUEST)


