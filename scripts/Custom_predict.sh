# ALL scripts in this file come from Autoformer
# enc_in dec_in c_out 모두 다 학습시킬 데이터의 컬럼수를 입력하면 됨
# --features 는 단일스탭, 다중스탭 결정용 변수고
# --seq_len 는 입력시간단위
# --pred_len 는 예측 시간단위

if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

model_name=Autoformer
seq_len=96
label_len=36
pred_len=96
learning_rate=0.0001
batch_size=128
# 1 은 학습 3은 예측
is_training=3
ckpt='./ckpt/'

python -u run.py \
--is_training $is_training \
--root_path ./dataset/ \
--data_path all_dataset.csv \
--model_id seq_len_$seq_len_$pred_len \
--model $model_name \
--data custom \
--features M \
--target target \
--checkpoints $ckpt \
--seq_len $seq_len \
--label_len $label_len \
--pred_len $pred_len \
--e_layers 2 \
--d_layers 1 \
--factor 3 \
--enc_in 8 \
--dec_in 8 \
--c_out 8 \
--d_model 512 \
--learning_rate $learning_rate \
--des 'Exp' \
--batch_size $batch_size \
--itr 1 \
--train_epochs 50 \
--patience 12 \
|tee logs/LongForecasting/$model_name'_seq_len_'$seq_len'_''_pred_len_'$pred_len'_lr_'$learning_rate'_batch_'$batch_size.log