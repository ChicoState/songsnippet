from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase
from django.contrib.auth.models import User
from ..serializers import SongUploadSerializer
from ..views import SongUploadHelper

test_json = {'songName': 'TEST',
             'year': '201',
             'start': '1',
             'end': '2',
             'song': SimpleUploadedFile("file.mp4",
                                        b"file_content",
                                        content_type="video/mp4")}


class UploadTestCase(TestCase):
    def test_serializer_validation_valid(self):
        songUploadSerializer = SongUploadSerializer(data=test_json)
        self.assertEqual(songUploadSerializer.is_valid(), True)

    def test_serializer_validation_invalid(self):
        songUploadSerializer = SongUploadSerializer(data={'foo':'bar'})
        self.assertEqual(songUploadSerializer.is_valid(), False)

    def test_song_upload_success(self):
        owner = User.objects.create_user(username='testingUser',
                                         email='test.com',
                                         password='another test')
        owner.save()
        songUploadSerializer = SongUploadSerializer(data=test_json)
        response = SongUploadHelper(songUploadSerializer, owner)
        self.assertEqual(response.status_code, 201)
        owner.delete()

    def test_song_upload_fail(self):
        owner = User.objects.create_user(username='testingUser',
                                         email='test.com',
                                         password='another test')
        owner.save()
        songUploadSerializer = SongUploadSerializer(data={'foo':'bar'})
        response = SongUploadHelper(songUploadSerializer, owner)
        self.assertEqual(response.status_code, 400)
        owner.delete()





