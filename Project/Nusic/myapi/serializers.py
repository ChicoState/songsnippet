from rest_framework import serializers
from .models import SongModel
from django.contrib.auth.models import User
from rest_framework.validators import UniqueTogetherValidator
from .models import FeedbackModel
from django import forms

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
    class Meta:
        model = SongModel
        fields = ('songName', 'year', 'artist', 'start', 'end', 'song')

class SongFeedbackSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = FeedbackModel
        fields = ('creator', 'song', 'like')

class InitialSongRecommendationsSerializer(serializers.Serializer):
    count = serializers.IntegerField()

class SongUploadSerializer(forms.Form):
    songName = serializers.CharField(max_length=None, min_length=None, allow_blank=False,
                                     trim_whitespace=True)
    year = serializers.CharField(max_length=None, allow_blank=False, trim_whitespace=True)
    start = serializers.CharField(max_length=None, allow_blank=False, trim_whitespace=True)
    end = serializers.CharField(max_length=None, allow_blank=False, trim_whitespace=True)
    song = serializers.FileField()

