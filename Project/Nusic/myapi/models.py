from django.db import models

class SongModel(models.Model):
    name = models.CharField(max_length=60)
    artist = models.CharField(max_length=60)
    start = models.PositiveIntegerField()
    end = models.PositiveIntegerField()
    song = models.FileField(upload_to="mp3s")
    def __str__(self):
        return self.name

# Create your models here.
