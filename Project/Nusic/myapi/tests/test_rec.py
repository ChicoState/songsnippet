from django.test import TestCase
from ..views import RecommendSong
from .utils_testing import TestingUtils

testingUtils = TestingUtils()


class RecommendTestCase(TestCase):

    def test_song_recommendation_returns_song(self):
        owner = testingUtils.create_user()
        testingUtils.create_songs(1, owner)
        songRec = RecommendSong(owner, 1)
        self.assertIsNotNone(songRec)

    def test_song_recommendation_returns_multiple_songs(self):
        owner = testingUtils.create_user()
        testingUtils.create_songs(3, owner)
        songRecs = RecommendSong(owner, 3)
        self.assertEqual(len(songRecs), 3)

    def test_song_recommends_none(self):
        owner = testingUtils.create_user()
        songRec = RecommendSong(owner, 1)
        self.assertEqual(songRec, [])

    def test_song_recommends_not_liked_song(self):
        owner = testingUtils.create_user()
        testingUtils.create_songs(3, owner)
        testingUtils.like_songs(2, owner)
        songRecs = RecommendSong(owner, 1)
        self.assertEqual(songRecs[0].songName, "TESTss")

    def test_song_recommends_empty_full_likes(self):
        owner = testingUtils.create_user()
        testingUtils.create_songs(3, owner)
        testingUtils.like_songs(3, owner)
        songRecs = RecommendSong(owner, 1)
        self.assertEqual(songRecs, [])
