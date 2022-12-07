from django.test import TestCase
from .utils_testing import TestingUtils
from ..serializers import SongFeedbackSerializer
from ..views import SongModel, SongFeedbackHelper

testingUtils = TestingUtils()


class FeedbackTestCase(TestCase):
    def test_serializer_validation_valid(self):
        creator = testingUtils.create_user()
        testingUtils.create_songs(1, creator)
        song = SongModel.objects.get(songName="TEST")
        feedbackJson = {"song": song.id,
                        "like": True}
        feedbackSerializer = SongFeedbackSerializer(data=feedbackJson)
        self.assertEqual(feedbackSerializer.is_valid(), True)
        creator.delete()

    def test_serializer_validation_invalid(self):
        creator = testingUtils.create_user()
        testingUtils.create_songs(1, creator)
        feedbackJson = {"song": "song.id",
                        "like": True}
        feedbackSerializer = SongFeedbackSerializer(data=feedbackJson)
        self.assertEqual(feedbackSerializer.is_valid(), False)
        creator.delete()

    def test_song_feedback_response_success(self):
        creator = testingUtils.create_user()
        testingUtils.create_songs(4, creator)
        song = SongModel.objects.get(songName="TEST")
        feedbackJson = {"song": song.id,
                        "like": True}
        feedbackSerializer = SongFeedbackSerializer(data=feedbackJson,
                                                    context=testingUtils.get_serializer_context())
        response = SongFeedbackHelper(feedbackSerializer, creator)
        self.assertEqual(response.status_code, 201)
        self.assertIsNotNone(response.data['id'])

    def test_song_feedback_response_success_empty(self):
        creator = testingUtils.create_user()
        testingUtils.create_songs(4, creator)
        testingUtils.like_songs(3, creator)
        song = SongModel.objects.get(songName="TESTsss")
        feedbackJson = {"song": song.id,
                        "like": True}
        feedbackSerializer = SongFeedbackSerializer(data=feedbackJson,
                                                    context=testingUtils.get_serializer_context())
        response = SongFeedbackHelper(feedbackSerializer, creator)
        self.assertEqual(response.status_code, 204)


    def test_song_feedback_response_fail(self):
        creator = testingUtils.create_user()
        testingUtils.create_songs(4, creator)
        song = SongModel.objects.get(songName="TEST")
        feedbackJson = {"song": "song.id",
                        "like": True}
        feedbackSerializer = SongFeedbackSerializer(data=feedbackJson,
                                                    context=testingUtils.get_serializer_context())
        response = SongFeedbackHelper(feedbackSerializer, creator)
        self.assertEqual(response.status_code, 400)
