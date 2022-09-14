from django.shortcuts import render
from rest_framework import viewsets
from .serializers import SongSerializer
from .models import Song

class SongViewSet(viewsets.ModelViewSet):
    queryset=Song.objects.all().order_by('name')
    serializer_class=SongSerializer
 #Create your views here.
