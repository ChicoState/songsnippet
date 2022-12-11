from django.contrib import admin
from .models import SongModel, FeedbackModel

admin.site.register(SongModel)
admin.site.register(FeedbackModel)
