# Settings
MODEL=vgg16
DATASET=pascal_voc


# Session specification
SESSION=1
EPOCH=1
CHECKPOINT=10021

# Paths
OUTPUT_FOLDER="models/"$MODEL"/"$DATASET"/faster_rcnn_"$EPOCHS"ep"
STDOUT_PATH=$OUTPUT_FOLDER"/test_stdout.txt"
STDERR_PATH=$OUTPUT_FOLDER"/test_stderr.txt"

# Preprocessing routines
mkdir -p $OUTPUT_FOLDER

# Run main script
python test_net.py --dataset $DATASET --net $MODEL \
                   --checksession $SESSION --checkepoch $EPOCH --checkpoint $CHECKPOINT \
                   --cuda 1> $STDOUT_PATH 2> $STDERR_PATH
