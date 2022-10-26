# myapi/urls.py
from django.urls import include, path
from rest_framework import routers
from . import views
from .views import UserRecordView

router = routers.DefaultRouter()
router.register(r'songs', views.SongViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('user/', UserRecordView.as_view(), name='users')
]