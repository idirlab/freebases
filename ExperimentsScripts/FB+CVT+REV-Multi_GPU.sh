###FB4_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 300000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################
#training takes 4141.7184545993805 seconds
#-------------- Test result --------------
#Test average MRR : 0.9708371778545675
#Test average MR : 1.464009902868417
#Test average HITS@1 : 0.9572764455911368
#Test average HITS@3 : 0.9828492563363181
#Test average HITS@10 : 0.9898030429503718
#-----------------------------------------
#testing takes 686.737 seconds
##################################################

###FB4-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 3750.0674629211426 seconds
#-------------- Test result --------------
#Test average MRR : 0.9270783829999111
#Test average MR : 12.92465452373544
#Test average HITS@1 : 0.9133287111255979
#Test average HITS@3 : 0.9355960375570312
#Test average HITS@10 : 0.9513787297563121
#-----------------------------------------
#testing takes 4315.173 seconds
##################################################

###FB4-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 6398.788597822189 seconds
#-------------- Test result --------------
#Test average MRR : 0.9282715949669749
#Test average MR : 13.278827473668326
#Test average HITS@1 : 0.9156255507934878
#Test average HITS@3 : 0.9354588205069724
#Test average HITS@10 : 0.9512246688106973
#-----------------------------------------
#testing takes 3239.732 seconds
##################################################

###FB4-TransR:
dglke_train --model_name TransR --dataset Freebase --data_path ./data --format udd_hrt \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 \
--neg_sample_size 256 --regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.08 --batch_size_eval 1000 \
--test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter , \

################## Script Result #################
#training takes 50848.42991781235 seconds
#-------------- Test result --------------
#Test average MRR : 0.9356229425875358
#Test average MR : 6.071491524675283
#Test average HITS@1 : 0.9164512431060478
#Test average HITS@3 : 0.9488563563967994
#Test average HITS@10 : 0.9696259039083073
#-----------------------------------------
#testing takes 3232.020 seconds
##################################################

###FB4-RotatE:
dglke_train --model_name RotatE --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt   --batch_size 1024 --neg_sample_size 256 -de \
--hidden_dim 200 --gamma 12.0 --lr 0.01 --regularization_coef 1e-7 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 \
--force_sync_interval 10000 --no_save_emb --delimiter , 

################## Script Result #################
training takes 7725.889139175415 seconds
-------------- Test result --------------
Test average MRR : 0.7299357109474364
Test average MR : 33.02714078894227
Test average HITS@1 : 0.6837280912702414
Test average HITS@3 : 0.7535836715579973
Test average HITS@10 : 0.8160462612280308
-----------------------------------------
testing takes 1123.047 seconds		
##################################################
