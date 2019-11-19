#! usr/bin/bash

# Paths
THIS_SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
RELATIVE_CWD=".."
MODELS_PATH="models"

cd $THIS_SCRIPT_PATH"/"$RELATIVE_CWD

for MODEL in $(dir $MODELS_PATH)
do
    echo "Model: "$MODEL
    FOLDER_PATH=$MODELS_PATH"/"$MODEL
    if [ -d $FOLDER_PATH ]
    then
        for DATASET in $(dir $FOLDER_PATH)
        do
            echo "  Dataset: "$DATASET
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
                    echo "    Session: "$SESSION
                    EPOCH_NUMS=$(find $DATASET_PATH -regex .*faster_rcnn_$SESSION\_[0-9]*_[0-9]*\.pth | sed  "s/.*faster_rcnn_$SESSION\_//g" | sed "s/_[0-9]*\.pth//g" | uniq | sort -n)

                    for EPOCH in $EPOCH_NUMS
                    do
                        PATH_TO_RESULT_FOLDER=$(find $DATASET_PATH -regex .*faster_rcnn_$SESSION\_$EPOCH\ ep)
                        PATH_TO_TEST_OUTPUT=$(find $PATH_TO_RESULT_FOLDER -regex test_stdout.txt)

                        MEAN_AP=$(sed -n "/Mean AP = .*/p" "$MODELS_PATH"/"$MODEL"/"$DATASET"/faster_rcnn_"$SESSION"_"$EPOCH"ep/test_stdout.txt | sed "s/Mean AP = //g")
                        echo "      Epoch: "$EPOCH"\t| mAP:"$MEAN_AP
                    done

                done
            fi
        done
    fi
done