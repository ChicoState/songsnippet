# myapi/urls.py
from django.urls import include, path
from rest_framework import routers
from . import views
from .views import UserRecordView

router = routers.DefaultRouter()
router.register(r'allsongs', views.SongViewSet)
router.register(r'allusers', views.UserViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('songfeedback/', views.SongFeedback),
    path('initialrec/', views.InitialSongRecommendations),
    path('user/', UserRecordView.as_view(), name='users'),
    path('songupload/', views.SongUpload)
]