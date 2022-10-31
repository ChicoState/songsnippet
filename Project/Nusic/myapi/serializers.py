from rest_framework import serializers
from .models import SongModel
from django.contrib.auth.models import User
from rest_framework.validators import UniqueTogetherValidator


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
from .models import FeedbackModel



class SongModelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = SongModel
        fields = ('songName', 'year', 'artist', 'start', 'end', 'song')

class SongFeedbackSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = FeedbackModel
        fields = ('creator', 'song', 'like')

class InitialSongRecommendationsSerializer(serializers.Serializer):
    count = serializers.IntegerField()
