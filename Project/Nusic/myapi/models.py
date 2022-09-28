from django.db import models

class Song(models.Model):
    name = models.CharField(max_length=60)
    artist = models.CharField(max_length=60)
    song = models.FileField(upload_to='mp3s')

    def __str__(self):
        return self.name
# Create your models here.
