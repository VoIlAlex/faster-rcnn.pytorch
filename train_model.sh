# Settings
MODEL=vgg16
DATASET=pascal_voc

# Framework
GPU_ID=0
WORKER_NUMBER=1

# Hyperparameters
BATCH_SIZE=1
LEARNING_RATE=0.001
DECAY_STEP=5
EPOCHS=2

# Paths
OUTPUT_FOLDER="models/"$MODEL"/"$DATASET"/faster_rcnn_"$EPOCHS"ep"
STDOUT_PATH=$OUTPUT_FOLDER"/train_stdout.txt"
STDERR_PATH=$OUTPUT_FOLDER"/train_stderr.txt"

# Preprocessing routines
mkdir -p $OUTPUT_FOLDER


# Run main script
CUDA_VISIBLE_DEVICES=$GPU_ID python trainval_net.py \
                   --dataset pascal_voc --net vgg16 \
                   --bs $BATCH_SIZE --nw $WORKER_NUMBER \
                   --lr $LEARNING_RATE --lr_decay_step $DECAY_STEP \
                   --cuda --epochs $EPOCHS 1> $STDOUT_PATH 2> $STDERR_PATH