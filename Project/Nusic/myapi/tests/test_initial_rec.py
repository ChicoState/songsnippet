from django.test import TestCase
from ..views import InitialSongRecommendationsHelper
from ..serializers import InitialSongRecommendationsSerializer
from .utils_testing import TestingUtils

testingUtils = TestingUtils()


class InitialRecommendationTestCase(TestCase):

    def test_success_remaining_recs(self):
        owner = testingUtils.create_user()
        testingUtils.create_songs(20, owner)
        testingUtils.like_songs(19, owner)
        response = InitialSongRecommendationsHelper(owner, testingUtils.get_serializer_context())
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['songName'], "TESTsssssssssssssssssss")

    def test_error(self):
        owner = testingUtils.create_user()
        response = InitialSongRecommendationsHelper(owner, testingUtils.get_serializer_context())
        self.assertEqual(response.status_code, 204)

