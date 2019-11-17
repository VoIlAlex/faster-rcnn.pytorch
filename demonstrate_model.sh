# Settings
MODEL=vgg16

# Session specification
SESSION=1
EPOCH=1
CHECKPOINT=10021

# Paths
MODELS_PATH=models

# Run main script
python demo.py --net $MODEL \
               --checksession $SESSION --checkepoch $EPOCH --checkpoint $CHECKPOINT \
               --cuda --load_dir $MODELS_PATH