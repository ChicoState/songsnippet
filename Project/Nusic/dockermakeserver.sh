#docker build -t jherrera/csci430:nusic_latest .
#docker run -it -p 80:80 jherrera/csci430:nusic_latest
docker build -t us.gcr.io/songsnippet-363719/songsnippet:latest .
docker push us.gcr.io/songsnippet-363719/songsnippet:latest