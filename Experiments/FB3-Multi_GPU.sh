###FB3_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 320000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################
training takes 2956.6212611198425 seconds
-------------- Test result --------------
Test average MRR : 0.4318185867998478
Test average MR : 50.57214016475221
Test average HITS@1 : 0.33940630346508155
Test average HITS@3 : 0.4667762212090888
Test average HITS@10 : 0.6230065289802794
-----------------------------------------
testing takes 481.997 seconds
##################################################

###FB3-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################
training takes 2596.1688351631165 seconds
-------------- Test result --------------
Test average MRR : 0.40879985295618626
Test average MR : 109.19316833087974
Test average HITS@1 : 0.31846544565151297
Test average HITS@3 : 0.4548951587051944
Test average HITS@10 : 0.5815069279860307
-----------------------------------------
testing takes 478.526 seconds
##################################################

###FB3-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################
training takes 3569.654488801956 seconds
-------------- Test result --------------
Test average MRR : 0.5102697184254522
Test average MR : 104.31735888972051
Test average HITS@1 : 0.43902471433365287
Test average HITS@3 : 0.5507716238220322
Test average HITS@10 : 0.6359782322281037
-----------------------------------------
testing takes 483.267 seconds
##################################################

###FB3-RotatE:
dglke_train --model_name RotatE --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt   --batch_size 1024 --neg_sample_size 256 -de \
--hidden_dim 200 --gamma 12.0 --lr 0.01 --regularization_coef 1e-7 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 \
--force_sync_interval 10000 --no_save_emb --delimiter , 

################## Script Result #################
training takes 7719.052458763123 seconds
-------------- Test result --------------
Test average MRR : 0.19878097954718577
Test average MR : 195.00103463730264
Test average HITS@1 : 0.14779931249394734
Test average HITS@3 : 0.21071557533776605
Test average HITS@10 : 0.292841243756855
-----------------------------------------
testing takes 622.786 seconds		
##################################################
