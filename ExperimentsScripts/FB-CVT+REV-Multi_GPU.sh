###FB2_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 300000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################	
#training takes 4121.8191702365875 seconds
#-------------- Test result --------------
#Test average MRR : 0.9763213880159973
#Test average MR : 1.5305391278875125
#Test average HITS@1 : 0.9685064445932373
#Test average HITS@3 : 0.9823450786742551
#Test average HITS@10 : 0.9882881653833278
#-----------------------------------------
#testing takes 375.262 seconds
##################################################

###FB2-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################		
#training takes 3758.5305144786835 seconds
#-------------- Test result --------------
#Test average MRR : 0.9526767334453051
#Test average MR : 9.239715094002342
#Test average HITS@1 : 0.9415316965412521
#Test average HITS@3 : 0.960815006095875
#Test average HITS@10 : 0.9706979977678586
#-----------------------------------------
#testing takes 3789.257 seconds
##################################################

###FB2-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################			
#training takes 6392.2116367816925 seconds
#-------------- Test result --------------
#Test average MRR : 0.9588731931000728
#Test average MR : 8.437821866214794
#Test average HITS@1 : 0.9507851409951441
#Test average HITS@3 : 0.9640386895576089
#Test average HITS@10 : 0.9726848061069888
#-----------------------------------------
#testing takes 2789.867 seconds
##################################################

###FB2-TransR:
dglke_train --model_name TransR --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 \
--regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.04 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 --force_sync_interval 10000 \
--no_save_emb --delimiter ,

################## Script Result #################	
training takes 50476.92552566528 seconds
-------------- Test result --------------
Test average MRR : 0.9445061599643565
Test average MR : 5.982025830642467
Test average HITS@1 : 0.9314820809395614
Test average HITS@3 : 0.9524096196990827
Test average HITS@10 : 0.9677813258009162
-----------------------------------------
testing takes 3941.365 seconds
##################################################

###FB2-RotatE:
dglke_train --model_name RotatE --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt   --batch_size 1024 --neg_sample_size 256 -de \
--hidden_dim 200 --gamma 12.0 --lr 0.04 --regularization_coef 1e-7 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 \
--force_sync_interval 10000 --no_save_emb --delimiter , 

################## Script Result #################	
#training takes 28190.836284399033 seconds
#-------------- Test result --------------
#Test average MRR : 0.9628581159023002
#Test average MR : 10.431722225272205
#Test average HITS@1 : 0.9561724667304485
#Test average HITS@3 : 0.9667817077555196
#Test average HITS@10 : 0.974667095263696
#-----------------------------------------
#testing takes 2976.206 seconds
##################################################
