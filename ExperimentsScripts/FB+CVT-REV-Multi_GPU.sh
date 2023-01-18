###FB3_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 300000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################
training takes 4041.0175344944 seconds
-------------- Test result --------------
Test average MRR : 0.7818002258285167
Test average MR : 4.8501746996997
Test average HITS@1 : 0.7082101351351351
Test average HITS@3 : 0.8351258258258258
Test average HITS@10 : 0.902649024024024
-----------------------------------------
testing takes 292.423 seconds
##################################################

###FB3-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################
training takes 3770.7201669216156 seconds
-------------- Test result --------------
Test average MRR : 0.6123300369731052
Test average MR : 81.84182180846072
Test average HITS@1 : 0.5626456295920382
Test average HITS@3 : 0.6355506241831268
Test average HITS@10 : 0.7047388970925506
-----------------------------------------
testing takes 2106.262 seconds
##################################################

###FB3-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################
training takes 6379.71839261055 seconds
-------------- Test result --------------
Test average MRR : 0.6244986385524888
Test average MR : 83.2050725905195
Test average HITS@1 : 0.5776080825127378
Test average HITS@3 : 0.6476089308222371
Test average HITS@10 : 0.7089381041859194
-----------------------------------------
testing takes 1535.467 seconds
##################################################

###FB#-TransR: 
nohup  dglke_train --model_name TransR --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 \
--regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.04 --batch_size_eval 1000 --test -adv --mix_cpu_gpu \
--num_proc 8 --num_thread 4 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update \
--rel_part --force_sync_interval 10000 --no_save_emb --delimiter , &

################## Script Result #################
training takes 51645.34634184837 seconds
-------------- Test result --------------
Test average MRR : 0.6404781157552277
Test average MR : 47.52457785341662
Test average HITS@1 : 0.5802951216198057
Test average HITS@3 : 0.6699268276753092
Test average HITS@10 : 0.7548086761792441
-----------------------------------------
testing takes 1608.461 seconds
##################################################

###FB3-RotatE:
dglke_train --model_name RotatE --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt   --batch_size 1024 --neg_sample_size 256 -de \
--hidden_dim 200 --gamma 12.0 --lr 0.08 --regularization_coef 1e-7 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 \
--force_sync_interval 10000 --no_save_emb --delimiter , 

################## Script Result #################		
training takes 28166.82656979561 seconds
-------------- Test result --------------
Test average MRR : 0.7360399383340532
Test average MR : 68.4366300041815
Test average HITS@1 : 0.6990771443650103
Test average HITS@3 : 0.7542370807342907
Test average HITS@10 : 0.8073460599777338
-----------------------------------------
testing takes 1749.506 seconds
##################################################
