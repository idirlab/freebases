###FB4_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 320000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################
training takes 342.3868455886841 seconds
-------------- Test result --------------
Test average MRR : 0.6062352081069878
Test average MR : 12.542271285475794
Test average HITS@1 : 0.5154369403551373
Test average HITS@3 : 0.6571414099256336
Test average HITS@10 : 0.7716209971164061
-----------------------------------------
testing takes 271.252 seconds
##################################################

###FB4-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################
training takes 2661.189035654068 seconds
-------------- Test result --------------
Test average MRR : 0.8187715508637831
Test average MR : 19.18095249042686
Test average HITS@1 : 0.7778721137093453
Test average HITS@3 : 0.8429859477145755
Test average HITS@10 : 0.8908468526460356
-----------------------------------------
testing takes 843.701 seconds
##################################################

###FB4-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################
training takes 3559.9117217063904 seconds
-------------- Test result --------------
Test average MRR : 0.8993861574131577
Test average MR : 16.93782000082095
Test average HITS@1 : 0.8800847035500938
Test average HITS@3 : 0.9102664226274519
Test average HITS@10 : 0.9355053688399617
-----------------------------------------
testing takes 845.329 seconds
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
