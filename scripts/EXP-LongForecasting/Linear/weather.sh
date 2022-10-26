
if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/LongForecasting" ]; then
    mkdir ./logs/LongForecasting
fi

####################################
# 변수 설정
####################################
seq_len=72
model_name=DLinear

# DLinear-I를 사용하려면  --individual  추가하면 됨
# DLinear-I 의 설명은 다음과 같음
#당연하게도 만약에 데이터셋를 구성하는 Variate가 다른 주기성과 다른 트렌드를 가지고 있다면 
#다른 Variate 사이에 Weight를 공유하는 DLinear의 경우 성능이 좋지 못할 것이기 때문에 
#두가지 디자인의 DLinear을 제안합니다. 
#우리는 모든 Variate가 같은 Linear Layer를 공유하는 형태를 DLinear-S라 하고, 
#각각의 Variate가 각기 다른 Linear Layer를 가지는 형태를 DLinear-I라고 하였으며, 
#기본적으로는 DLinear-S를 사용하였습니다.


####################################################################
# 실행 설정 
####################################################################

# 학습 시 사용
python -u run_longExp.py \  
  --is_training 1 \        
  --root_path ./dataset/ \  
  --data_path powerplant1.csv \ 
  --model_id powerplant1_$seq_len'_'24 \ 
  --model $model_name \     
  --data custom \          
  --features M \
  --target target \            
  --seq_len $seq_len \
  --pred_len 24 \
  --individual False \
  --enc_in 21 \
  --des 'Exp' \
  --itr 1 \
  --train_epochs 100 \
  --batch_size 32 \
  0> >logs/LongForecasting/$model_name'_'powerplant1_$seq_len'_'24.log

