# Generated by Django 3.2.13 on 2022-12-07 01:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapi', '0003_alter_feedbackmodel_creator_alter_songmodel_artist_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='feedbackmodel',
            name='like',
            field=models.BooleanField(blank=True, null=True),
        ),
    ]
