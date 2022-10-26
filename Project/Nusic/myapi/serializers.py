from rest_framework import serializers
from .models import SongModel
from .models import FeedbackModel



class SongModelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = SongModel
        fields = ('songName', 'year', 'artist', 'start', 'end', 'song')

class SongFeebackSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = FeedbackModel
        fields = ('creator', 'song', 'like')
