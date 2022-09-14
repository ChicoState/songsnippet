from django.db import models

class Song(models.Model):
    name = models.CharField(max_length=60)
    artist=models.CharField(max_length=60)

    def __str__(self):
        return self.name
# Create your models here.
