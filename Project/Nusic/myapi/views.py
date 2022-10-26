from rest_framework.decorators import api_view
from .serializers import SongModelSerializer
from .serializers import SongFeebackSerializer
from .models import SongModel
from rest_framework.response import Response
from rest_framework import viewsets, status




class SongViewSet(viewsets.ModelViewSet):
    queryset = SongModel.objects.all().order_by('name')
    serializer_class = SongModelSerializer


@api_view(['POST'])
def SongFeedback(request):
    songFeedbackSerializer = SongFeebackSerializer(data=request.data)

    if songFeedbackSerializer.is_valid():

        prevLikeObject = SongFeedback.objects.filter(
            creator=request.user,
            song=songFeedbackSerializer.data['song']
        ).first()

        #if a like or dislike somehow exists, delete before creating a new one
        if prevLikeObject is not None:
            prevLikeObject.delete()

        songFeedbackSerializer.save()
        return Response(status=status.HTTP_201_CREATED)
    return Response(songFeedbackSerializer.errors, status=status.HTTP_400_BAD_REQUEST)
