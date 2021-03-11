#!/bin/bash
 
USER=cleong
MACHINE=saturn
SERVER_DATA_DIR=/home/nlp-speech/static/Corpora/multimodal_assessments/data/test
DOCKER_DATA_DIR=/opt/OpenFace/build/bin/data
VIDEO_DATA_DIR=video
 
mkdir -p $DOCKER_DATA_DIR
 
sshfs -o idmap=user $USER@$MACHINE.research.ets.org:$SERVER_DATA_DIR $DOCKER_DATA_DIR
 
./FeatureExtraction -q -f $DOCKER_DATA_DIR/$VIDEO_DATA_DIR/test.mp4 -out_dir $DOCKER_DATA_DIR/$VIDEO_DATA_DIR -of test.features

