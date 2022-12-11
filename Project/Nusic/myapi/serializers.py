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
        fields = ('songName', 'year', 'artist', 'start', 'end', 'song', 'id')


class SongFeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = FeedbackModel
        fields = ('song', 'like')


class InitialSongRecommendationsSerializer(serializers.Serializer):
    count = serializers.IntegerField()


class SongUploadSerializer(forms.Form):
    songName = forms.CharField(required=True)
    year = forms.CharField(required=True)
    start = forms.CharField(required=True)
    end = forms.CharField(required=True)
    song = forms.FileField(required=False)
