from django.db import models
from django.contrib.auth.models import User


class SongModel(models.Model):
    songName = models.CharField(max_length=60)
    artist = models.ForeignKey(User, on_delete=models.CASCADE)
    year = models.PositiveIntegerField()
    start = models.PositiveIntegerField()
    end = models.PositiveIntegerField()
    song = models.FileField(upload_to="mp3s")

    def __str__(self):
        return self.name


class FeedbackModel(models.Model):
    creator = models.ForeignKey(User, on_delete=models.CASCADE)
    song = models.ForeignKey(SongModel, on_delete=models.CASCADE)
    like = models.BooleanField()
