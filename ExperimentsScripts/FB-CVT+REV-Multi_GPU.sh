###FB2_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 300000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################	
training takes 4121.8191702365875 seconds
-------------- Test result --------------
Test average MRR : 0.9763213880159973
Test average MR : 1.5305391278875125
Test average HITS@1 : 0.9685064445932373
Test average HITS@3 : 0.9823450786742551
Test average HITS@10 : 0.9882881653833278
-----------------------------------------
testing takes 375.262 seconds
##################################################

###FB2-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################		
training takes 3804.3522222042084 seconds
-------------- Test result --------------
Test average MRR : 0.9535371670895816
Test average MR : 8.745189497687852
Test average HITS@1 : 0.9426758447356212
Test average HITS@3 : 0.9613245439140673
Test average HITS@10 : 0.9712074518974876
-----------------------------------------
testing takes 2577.520 seconds
##################################################

###FB2-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################			
training takes 6408.37660574913 seconds
-------------- Test result --------------
Test average MRR : 0.9605999808314448
Test average MR : 7.923122430342661
Test average HITS@1 : 0.9528958502523712
Test average HITS@3 : 0.9654103451115501
Test average HITS@10 : 0.9738982902761254
-----------------------------------------
testing takes 2568.847 seconds
##################################################

###FB2-TransR:
dglke_train --model_name TransR --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 \
--regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.015 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 --force_sync_interval 10000 \
--no_save_emb --delimiter ,

################## Script Result #################	
training takes 50961.72805142403 seconds
-------------- Test result --------------
Test average MRR : 0.9383832795919214
Test average MR : 6.149904670357444
Test average HITS@1 : 0.9230476127669917
Test average HITS@3 : 0.9480705769087855
Test average HITS@10 : 0.9655775130169192
-----------------------------------------
testing takes 3920.482 seconds
##################################################

###FB2-RotatE:
dglke_train --model_name RotatE --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt   --batch_size 1024 --neg_sample_size 256 -de \
--hidden_dim 200 --gamma 12.0 --lr 0.04 --regularization_coef 1e-7 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 \
--force_sync_interval 10000 --no_save_emb --delimiter , 

################## Script Result #################	
training takes 28190.836284399033 seconds
-------------- Test result --------------
Test average MRR : 0.9628581159023002
Test average MR : 10.431722225272205
Test average HITS@1 : 0.9561724667304485
Test average HITS@3 : 0.9667817077555196
Test average HITS@10 : 0.974667095263696
Test average dge : 913.7961486355752
-----------------------------------------
testing takes 2976.206 seconds
##################################################
