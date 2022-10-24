
if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

####################################
# 변수 설정
####################################
seq_len=336
model_name=DLinear
data_file = weather.csv

# DLinear-I를 사용하려면  --individual  추가하면 됨
# DLinear-I 의 설명은 다음과 같음
'''
당연하게도 만약에 데이터셋를 구성하는 Variate가 다른 주기성과 다른 트렌드를 가지고 있다면 
다른 Variate 사이에 Weight를 공유하는 DLinear의 경우 성능이 좋지 못할 것이기 때문에 
두가지 디자인의 DLinear을 제안합니다. 
우리는 모든 Variate가 같은 Linear Layer를 공유하는 형태를 DLinear-S라 하고, 
각각의 Variate가 각기 다른 Linear Layer를 가지는 형태를 DLinear-I라고 하였으며, 
기본적으로는 DLinear-S를 사용하였습니다.
'''

####################################################################
# 실행 설정 
####################################################################

python -u run_longExp.py \  # 실행파일 경로 설정
  --is_training 1 \         # 학습 모드인지 설정
  --root_path ./dataset/ \  # 데이터 루트 폴더 설정
  --data_path $data_file \ # 데이터 파일 이름
  --model_id $data_file_$seq_len'_'96 \  # ckpt를 남기기위한 모델 id 설정
  --model $model_name \     # 사용할 모델 이름 설정
  --data custom \           # 커스텀 데이터만을 사용할거라 건들필요 X
  --features M \            
  --seq_len $seq_len \
  --pred_len 96 \
  --enc_in 21 \
  --des 'Exp' \
  --itr 1 --batch_size 16  >logs/LongForecasting/$model_name'_'$data_file_$seq_len'_'96.log

