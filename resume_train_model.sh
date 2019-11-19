# Settings
MODEL=vgg16
DATASET=pascal_voc

# Resuming
CHECKSESSION=1
CHECKEPOCH=12
CHECKPOINT=10021

# Framework
GPU_ID=0
WORKER_NUMBER=1

# Hyperparameters
BATCH_SIZE=1
LEARNING_RATE=0.001
DECAY_STEP=5
EPOCHS=100

# Paths
OUTPUT_FOLDER="models/"$MODEL"/"$DATASET"/faster_rcnn_"$EPOCHS"ep"
STDOUT_PATH=$OUTPUT_FOLDER"/train_stdout.txt"
STDERR_PATH=$OUTPUT_FOLDER"/train_stderr.txt"

# Preprocessing routines
mkdir -p $OUTPUT_FOLDER


# Run main script
CUDA_VISIBLE_DEVICES=$GPU_ID python3 trainval_net.py \
                   --dataset $DATASET --net $MODEL \
                   --bs $BATCH_SIZE --nw $WORKER_NUMBER \
                   --lr $LEARNING_RATE --lr_decay_step $DECAY_STEP \
                   --cuda --epochs $EPOCHS --r RESUME \
                   --checksession $CHECKSESSION \
                   --checkepoch $CHECKEPOCH \
                   --checkpoint $CHECKPOINT
                  #
                  # I comment this because I changed
                  # source code so it put output to the
                  # right directory
                  #
                  #    1> $STDOUT_PATH 2> $STDERR_PATH