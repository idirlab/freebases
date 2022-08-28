###FB2_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt --batch_size 1000 --neg_sample_size 200 --hidden_dim 400 --gamma 10 \
--lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 320000 \
--neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em --delimiter ,

################## Script Result #################
#training takes 5101.143152475357 seconds				
#-------------- Test result --------------				
#Test average MRR : 0.9584146732646772				
#Test average MR : 3.8572104222458923				
#Test average HITS@1 : 0.944642421846075				
#Test average HITS@3 : 0.9687035395055932				
#Test average HITS@10 : 0.9805162981671978				
#-----------------------------------------				
#testing takes 2996.034 seconds				
##################################################

###FB2-DistMult:
dglke_train --model_name DistMult --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 \
--eval_interval 100000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 4468.175311803818 seconds				
#-------------- Test result --------------				
#Test average MRR : 0.9655495611175791				
#Test average MR : 6.059219929467593				
#Test average HITS@1 : 0.9566442523024347				
#Test average HITS@3 : 0.9721253607620737				
#Test average HITS@10 : 0.9798049309448099				
#-----------------------------------------				
#testing takes 2714.824 seconds				
##################################################

###FB2-ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 --hidden_dim 400 --gamma 143.0 \
--lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 5812.243706226349 seconds				
#-------------- Test result --------------				
#Test average MRR : 0.9704259855549703				
#Test average MR : 5.567835764139034				
#Test average HITS@1 : 0.9640717267588309				
#Test average HITS@3 : 0.9744795149698624				
#Test average HITS@10 : 0.981248871688885				
#-----------------------------------------				
#testing takes 2235.539 seconds				
##################################################

###FB2-TransR:
dglke_train --model_name TransR --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt  --batch_size 1024 --neg_sample_size 256 \
--regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.015 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 \
--max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 --force_sync_interval 10000 \
--no_save_emb --delimiter ,

################## Script Result #################
#training takes 38846.226581811905 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.9522504864998791			
#Test average MR : 4.655780199725092			
#Test average HITS@1 : 0.9392195588885758			
#Test average HITS@3 : 0.9609789643710374			
#Test average HITS@10 : 0.9747066221110561			
#-----------------------------------------			
#testing takes 2745.337 seconds			
##################################################

###FB2-RotatE:
dglke_train --model_name RotatE --dataset Freebase --data_path ./data --format udd_hrt  \
--data_files entity2id.txt relation2id.txt train.txt valid.txt test.txt   --batch_size 1024 --neg_sample_size 256 -de \
--hidden_dim 200 --gamma 12.0 --lr 0.01 --regularization_coef 1e-7 --batch_size_eval 1000 --test -adv --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --log_interval 1000 --async_update --rel_part --num_thread 4 \
--force_sync_interval 10000 --no_save_emb --delimiter , 

################## Script Result #################
#training takes 25718.310868263245 seconds				
#-------------- Test result --------------				
#Test average MRR : 0.9381217966586313				
#Test average MR : 13.513383937201475				
#Test average HITS@1 : 0.9267286661229241				
#Test average HITS@3 : 0.9455800462577809				
#Test average HITS@10 : 0.9569705488275254				
#-----------------------------------------				
#testing takes 2845.777 seconds				
##################################################
