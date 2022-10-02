from rest_framework import serializers
from .models import SongModel


class SongModelSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model=SongModel
        fields=('name', 'artist','start', 'end', 'song')