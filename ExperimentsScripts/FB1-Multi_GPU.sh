###FB1_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 300000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################
training takes 4121.826884031296 seconds
-------------- Test result --------------
Test average MRR : 0.8062901031247999
Test average MR : 5.869447170716112
Test average HITS@1 : 0.7577304987212277
Test average HITS@3 : 0.8377261029411764
Test average HITS@10 : 0.8847241048593351
-----------------------------------------
testing takes 278.203 seconds
##################################################

###FB1-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 4481.721693754196 seconds				
#-------------- Test result --------------				
#Test average MRR : 0.7096351943255073				
#Test average MR : 69.38829734691518				
#Test average HITS@1 : 0.6703651926771133				
#Test average HITS@3 : 0.7306864122159474				
#Test average HITS@10 : 0.780517281672224				
#-----------------------------------------				
#testing takes 1579.544 seconds
##################################################

###FB1-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 5881.848418712616 seconds				
#-------------- Test result --------------				
#Test average MRR : 0.7179405798869858				
#Test average MR : 68.7989690545715				
#Test average HITS@1 : 0.6812835891974892				
#Test average HITS@3 : 0.7374767304961805				
#Test average HITS@10 : 0.7831064406131745				
#-----------------------------------------				
#testing takes 1183.343 seconds	
##################################################

###FB1-TransR:
dglke_train --model_name TransR --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 \
--regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.015 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 --force_sync_interval 10000 \
--no_save_emb --delimiter ,

################## Script Result #################
#training takes 49449.76291227341 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.6363734517471373			
#Test average MR : 52.251309838161504			
#Test average HITS@1 : 0.5842527698539663			
#Test average HITS@3 : 0.6597560858084537			
#Test average HITS@10 : 0.7330448838412068			
#-----------------------------------------			
#testing takes 1595.097 seconds			
##################################################

###FB1-RotatE:
dglke_train --model_name RotatE --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt   --batch_size 1024 --neg_sample_size 256 -de \
--hidden_dim 200 --gamma 12.0 --lr 0.01 --regularization_coef 1e-7 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 \
--force_sync_interval 10000 --no_save_emb --delimiter , 

################## Script Result #################
#training takes 25748.069131851196 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.45551810443922747			
#Test average MR : 143.6880176912476			
#Test average HITS@1 : 0.3999739598391252			
#Test average HITS@3 : 0.4778791142249549			
#Test average HITS@10 : 0.5598818294688691			
#-----------------------------------------			
#testing takes 1267.891 seconds			
##################################################
