from rest_framework.decorators import api_view
from .serializers import SongModelSerializer
from .serializers import SongFeedbackSerializer
from .serializers import InitialSongRecommendationsSerializer
from .models import SongModel
from .models import FeedbackModel
from rest_framework import viewsets
import random
from .serializers import UserSerializer
from .serializers import SongUploadSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from django.contrib.auth.models import User
from django.forms.models import model_to_dict
from rest_framework.request import Request


class UserRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAdminUser]

    def get(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            serializer.create(validated_data=request.data)
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )


class SongViewSet(viewsets.ModelViewSet):
    queryset = SongModel.objects.all().order_by('artist')
    serializer_class = SongModelSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class LikeViewSet(viewsets.ModelViewSet):
    queryset = FeedbackModel.objects.all().order_by('creator')
    serializer_class = SongFeedbackSerializer


# not sure if this works until we test
def RecommendSong(user, count):
    excluded_song_ids = FeedbackModel.objects.filter(creator=user.id).values('song')
    possible_songs = SongModel.objects.exclude(id__in=excluded_song_ids)[::1]
    random.shuffle(possible_songs)
    if len(possible_songs) == 0:
        return []
    if count > len(possible_songs):
        count = len(possible_songs)

    for i in range(count):
        dontRecAgain = FeedbackModel(creator=user, song=possible_songs[i])
        dontRecAgain.save()
    return possible_songs[0:count]


def SongFeedbackHelper(songFeedbackSerializer, owner, context):
    if songFeedbackSerializer.is_valid():
        prevLikeObject = FeedbackModel.objects.filter(
            creator=owner,
            song=songFeedbackSerializer.data['song']
        ).first()

        # if a like or dislike somehow exists, delete before creating a new one
        if prevLikeObject is not None:
            prevLikeObject.delete()

        feedback = FeedbackModel(
            creator=owner,
            song=SongModel.objects.get(id=songFeedbackSerializer.data['song']),
            like=songFeedbackSerializer.data['like']
        )
        feedback.save()

        recommendedSong = RecommendSong(owner, 1)

        if not recommendedSong:
            return Response(status=204)

        rec = SongModelSerializer(recommendedSong[0], context=context)

        return Response(rec.data, status=status.HTTP_201_CREATED)
    return Response(songFeedbackSerializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def SongFeedback(request):
    return SongFeedbackHelper(SongFeedbackSerializer(data=request.data), request.user, {"request": request})


# seperate function for testing purposes
def SongUploadHelper(songUploadSerializer, owner):
    if songUploadSerializer.is_valid():
        newSong = SongModel(
            songName=songUploadSerializer.data['songName'],
            artist=owner,
            year=int(songUploadSerializer.data['year']),
            start=int(songUploadSerializer.data['start']),
            end=int(songUploadSerializer.data['end']),
            song=songUploadSerializer.data['song']
        )
        newSong.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(songUploadSerializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def SongUpload(request):
    return SongUploadHelper(songUploadSerializer=SongUploadSerializer(data=request),
                            owner=request.user)


def InitialSongRecommendationsHelper(owner, context):
    recommendedSongs = RecommendSong(owner, 1)
    if recommendedSongs == []:
        return Response(status=204)

    recSongSerializer = SongModelSerializer(recommendedSongs[0], context=context)
    return Response(recSongSerializer.data, status=200)


@api_view(['GET'])
def InitialSongRecommendations(request):
    return InitialSongRecommendationsHelper(request.user, {"request": request})
