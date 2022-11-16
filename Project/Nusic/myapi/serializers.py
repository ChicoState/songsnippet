from rest_framework import serializers
from .models import SongModel
from django.contrib.auth.models import User
from rest_framework.validators import UniqueTogetherValidator
from .models import FeedbackModel


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

    class Meta:
        model = User
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
        )
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['username', 'email']
            )
        ]

class SongModelSerializer(serializers.HyperlinkedModelSerializer):
    id = serializers.IntegerField(read_only=True)
    class Meta:
        model = SongModel
        fields = ('songName', 'year', 'artist', 'start', 'end', 'song')

class SongFeedbackSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = FeedbackModel
        fields = ('creator', 'song', 'like')

class InitialSongRecommendationsSerializer(serializers.Serializer):
    count = serializers.IntegerField()

class SongUploadSerializer(serializers.Serializer):
    songName = serializers.CharField(max_length=None, min_length=None, allow_blank=False,
                                     trim_whitespace=True)
    year = serializers.IntegerField()
    start = serializers.IntegerField()
    end = serializers.IntegerField()
    song = serializers.FileField()

