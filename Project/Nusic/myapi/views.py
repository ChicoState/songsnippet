from django.shortcuts import render
from rest_framework import viewsets
from .serializers import SongModelSerializer
from .models import SongModel

class SongViewSet(viewsets.ModelViewSet):
    queryset=SongModel.objects.all().order_by('name')
    serializer_class=SongModelSerializer
 #Create your views here.
