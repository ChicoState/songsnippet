# Song Snippet

<img width="427" alt="Screen Shot 2022-12-11 at 8 37 26 PM" src="https://user-images.githubusercontent.com/52172832/206961960-72618ae6-25fc-4cc6-a573-507411527d1c.png">


## Dependencies 

### Django
- asgiref==3.5.2
- Django==4.1.1
- djangorestframework==3.13.1
- psycopg2==2.8.4
- django-storages==1.13.1
- sqlparse>=0.2.2
- google-cloud-storage==2.5.0
- django-cors-headers==3.13.0
- django-nose==1.4.7
- coverage==6.5.0

### Flutter 
- just_audio: ^0.9.15
- audio_video_progress_bar: ^0.9.0
- flutter_bloc: ^7.2.0
- meta: ^1.1.6
- equatable: ^2.0.5
- sqflite: ^2.1.0
- drift: ^2.2.0
- sqlite3_flutter_libs: ^0.5.0
- path_provider: ^2.0.0
- path: ^1.8.2
- mockito: ^5.3.2
- file_picker: ^5.2.1
- dart_code_metrics: ^5.1.0

## Testing with coverage

### Django
- from base django directory ```Nusic/``` run ```py manage.py test myapi/tests```

### Flutter
- run ```flutter test --coverage```


## Static analysis

### Django
- from directory ```myapi``` run ```python -m mccabe --min 1 views.py```

### Flutter
- run ```flutter pub run dart_code_metrics:metrics analyze lib```


