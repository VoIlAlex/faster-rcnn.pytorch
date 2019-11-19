#! usr/bin/bash


# Settings
if [ -z "$1" ]
then
    MODEL=vgg16
else
    MODEL=$1
fi

if [ -z "$2" ]
then
    DATASET=pascal_voc
else
    DATASET=$2
fi


# Session specification
if [ -z "$3" ]
then
    SESSION=1
else
    SESSION=$3
fi

if [ -z "$4" ]
then
    EPOCH=11
else
    EPOCH=$4
fi

if [ -z "$5" ]
then
    CHECKPOINT=10021
else   
    CHECKPOINT=$5
fi

# Paths
OUTPUT_FOLDER="models/"$MODEL"/"$DATASET"/faster_rcnn_"$SESSION"_"$EPOCH"ep"
STDOUT_PATH=$OUTPUT_FOLDER"/test_stdout.txt"
STDERR_PATH=$OUTPUT_FOLDER"/test_stderr.txt"

# Preprocessing routines
mkdir -p $OUTPUT_FOLDER

# Run main script
python3 test_net.py --dataset $DATASET --net $MODEL \
                   --checksession $SESSION --checkepoch $EPOCH --checkpoint $CHECKPOINT \
                   --cuda 1> $STDOUT_PATH 2> $STDERR_PATH
