# docker-images
Dockerfiles for some multimodal toolkits

# Plaform
All images are configured for Ubuntu 16.04 only

[openSMILE](http://audeering.com/technology/opensmile)
---------
Download these files into the same directory: [openSMILE opensmile-2.3.0.tar.gz](http://audeering.com/download/1318/opensmile-2.3.0.tar.gz) and [OpenCV 2.4.13.3.zip](https://github.com/opencv/opencv/archive/2.4.13.3.zip).
Then, run `docker build -t opensmile --file opensmile.dockerfile .`

[OpenFace](https://github.com/TadasBaltrusaitis/OpenFace)
---------
No downloads required. Run `docker build -t openface-cambridge --file openface-cambridge.dockerfile .`