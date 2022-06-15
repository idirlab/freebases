
###FB15K-237-TransE_l2:

################## Script Result #################

##################################################

###FB15K-237-DistMult:
CUDA_VISIBLE_DEVICES=0,1 nohup dglke_train --model_name DistMult --dataset FB15k-237 --batch_size 1000 --log_interval 1000 --neg_sample_size \
200 --hidden_dim 400 --gamma 143.0 --lr 0.08 --batch_size_eval 16 --test -adv --max_step 3000 --mix_cpu_gpu --num_proc 8 --num_thread 4 \
--gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter , &

################## Script Result #################

##################################################

###FB15K-237-ComplEx:
CUDA_VISIBLE_DEVICES=0,1 nohup dglke_train --model_name ComplEx --dataset FB15k-237 --batch_size 1000 --log_interval 1000 --neg_sample_size 200 \
--hidden_dim 400 --gamma 143.0 --lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 16 --test -adv --max_step 3000 \
--mix_cpu_gpu --num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter , &


################## Script Result #################

##################################################

###FB15K-237-TransR:
CUDA_VISIBLE_DEVICES=0,1 nohup dglke_train --model_name TransR --dataset FB15k-237 --batch_size 1000 --log_interval 1000 --neg_sample_size 200 \
--regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.015 --batch_size_eval 16 --test -adv --max_step 3000 --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --async_update --rel_part --num_thread 4 --force_sync_interval 1000 --no_save_emb --delimiter , &

################## Script Result #################

##################################################

###FB15K-237-RotatE:
CUDA_VISIBLE_DEVICES=0,1 nohup dglke_train --model_name RotatE --dataset FB15k-237 --batch_size 1024 --log_interval 1000 --neg_sample_size 256 \
--regularization_coef 1e-07 --hidden_dim 200 --gamma 12.0 --lr 0.009 --batch_size_eval 16 --test -adv -de --max_step 2500 --num_thread 4 \
--neg_deg_sample --mix_cpu_gpu --num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter , &

################## Script Result #################

##################################################

