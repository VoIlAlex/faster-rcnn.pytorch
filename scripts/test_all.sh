#! usr/bin/bash

# Paths
THIS_SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
RELATIVE_CWD=".."
MODELS_PATH="models"
TEST_SCRIPT_PATH="test_model.sh"

cd $THIS_SCRIPT_PATH"/"$RELATIVE_CWD


for MODEL in $(dir $MODELS_PATH)
do
    echo "Model: "$MODEL
    FOLDER_PATH=$MODELS_PATH"/"$MODEL
    if [ -d $FOLDER_PATH ]
    then
        for DATASET in $(dir $FOLDER_PATH)
        do
            echo "Dataset: "$DATASET
            DATASET_PATH=$FOLDER_PATH"/"$DATASET
            if [ -d $DATASET_PATH ]
            then
                # if there is no trained models
                if [ -z "$(find $DATASET_PATH -regex .*faster_rcnn_[0-9]*_[0-9]*_[0-9]*\.pth)" ]    
                then
                    exit
                fi

                SESSION_NUMS=$(find $DATASET_PATH -regex .*faster_rcnn_[0-9]*_[0-9]*_[0-9]*\.pth | sed "s/.*faster_rcnn_//" | sed "s/_[0-9]*_[0-9]*\.pth//" | uniq)

                for SESSION in $SESSION_NUMS
                do
                    echo "Session: "$SESSION
                    EPOCH_NUMS=$(find $DATASET_PATH -regex .*faster_rcnn_$SESSION\_[0-9]*_[0-9]*\.pth | sed  "s/.*faster_rcnn_$SESSION\_//g" | sed "s/_[0-9]*\.pth//g" | uniq)

                    for EPOCH in $EPOCH_NUMS
                    do
                        echo "Epoch: "$EPOCH

                        # EPOCH_MODELS=$(find $DATASET_PATH -regex .*faster_rcnn_$SESSION\_$EPOCH\_[0-9]*\.pth)
                        # CHECKPOINT_NUMS=$(find $DATASET_PATH -regex .*faster_rcnn_[0-9]*_[0-9]*_[0-9]*\.pth | sed "s/.*faster_rcnn_$SESSION\_$EPOCH//" | sed "s/\.pth//" | uniq)
                        CHECKPOINT_NUMS=$(find $DATASET_PATH -regex .*faster_rcnn_$SESSION\_$EPOCH\_[0-9]*\.pth | sed "s/.*faster_rcnn_$SESSION\_$EPOCH\_//" | sed "s/\.pth//" | uniq)

                        for CHECKPOINT in $CHECKPOINT_NUMS
                        do
                            echo "Checkpoint: "$CHECKPOINT
                            sh $TEST_SCRIPT_PATH $MODEL $DATASET $SESSION $EPOCH $CHECKPOINT

                        done
                    

                    done

                done
            fi
        done
    fi
done