#!/bin/bash
pid="1088622"
long_pid="$pid"

current=$(top -bn1 -p "$pid" | tail -n 1 | head -c7)

while [[ "$long_pid" = "$current" ]]
do
#
#echo "$current"
current=$(top -bn1 -p "$pid" | tail -n 1 | head -c7)
sleep 5
done

echo "starting next scripts, boq amstertime, different lr"
#export CUDA_VISIBLE_DEVICES=7
#python train_ref.py
python train_ref.py --gpu_id 6 --method salad --resume weights/gsv_salad.pth --dataset_name amstertime  --train_batch_size 16 --lr 1e-7 --patience 15 --epochs_num 200 --use_val_augments True

echo "starting next scripts, salad sped, different lr"
python train_ref.py --gpu_id 6 --method salad --resume weights/gsv_salad.pth --dataset_name sped  --train_batch_size 16 --lr 1e-7 --patience 15 --epochs_num 200 --use_val_augments True

echo "starting next scripts, boq amstertime, different lr"
python train_ref.py --gpu_id 6 --method boq --resume weights/gsv_boq.pth --dataset_name amstertime  --train_batch_size 16 --lr 1e-7 --patience 15 --epochs_num 200 --use_val_augments True
echo "starting next scripts, boq sped, different lr"

python train_ref.py --gpu_id 6 --method boq --resume weights/gsv_boq.pth --dataset_name sped  --train_batch_size 16 --lr 1e-7 --patience 15 --epochs_num 200 --use_val_augments True
echo "starting next scripts, boq eynsham, different lr"

python train_ref.py --gpu_id 6 --method boq --resume weights/gsv_boq.pth --dataset_name eynsham  --train_batch_size 16 --lr 1e-7 --patience 5 --epochs_num 100 --use_val_augments True

python train_ref.py --gpu_id 6 --method boq --resume weights/gsv_boq.pth --dataset_name nordland  --train_batch_size 16 --lr 1e-7 --patience 5 --epochs_num 100 --use_val_augments True


