from rest_framework import serializers
from .models import Song
from .models import SongModel


class SongSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model=Song
        fields=('name', 'artist')

class SongModelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model=SongModel
        fields=('name', 'artist', 'song')