#docker build -t jherrera/csci430:nusic_latest .
#docker run -it -p 80:80 jherrera/csci430:nusic_latest
docker build -t us.gcr.io/still-summit-335104/nusic:latest .
docker push us.gcr.io/still-summit-335104/nusic:latest