from django.contrib.auth.models import User
from django.core.files.uploadedfile import SimpleUploadedFile
from rest_framework.test import APIRequestFactory
from rest_framework.request import Request

from ..models import SongModel, FeedbackModel
from ..serializers import SongUploadSerializer
from ..views import SongUploadHelper


class TestingUtils:

    def get_serializer_context(self):
        factory = APIRequestFactory()
        request = factory.get('/')
        return {
            'request': Request(request),
        }

    def create_user(self):
        owner = User.objects.create_user(username='testingUser',
                                         email='test.com',
                                         password='another test')
        owner.save()
        return owner

    def create_songs(self, count, owner):
        songName = "TEST"
        for i in range(count):
            test_json = {'songName': songName,
                         'year': 2010,
                         'start': 1,
                         'end': 2,
                         'song': SimpleUploadedFile("file.mp4",
                                                    b"file_content",
                                                    content_type="video/mp4")}
            songUploadSerializer = SongUploadSerializer(data=test_json)
            SongUploadHelper(songUploadSerializer, owner)
            songName = songName + "s"


    def like_songs(self, count, owner):
        songName = "TEST"
        for i in range(count):
            song = SongModel.objects.get(songName=songName)
            feedback = FeedbackModel(creator=owner, song=song)
            feedback.save()
            songName = songName + "s"


