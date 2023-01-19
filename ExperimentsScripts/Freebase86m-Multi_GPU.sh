###Freebase86m_TransE_l2:
dglke_train --model_name TransE_l2 --dataset Freebase --batch_size 1000 --neg_sample_size 200 \
--hidden_dim 400 --gamma 10 --lr 0.1 --regularization_coef 1e-9 --batch_size_eval 1000 \
--test -adv --mix_cpu_gpu --num_proc 8 --num_thread 4 --gpu 0 1  --max_step 300000 --neg_sample_size_eval 1000 \
--log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --no_save_em &

################## Script Result #################
#training takes 5180.231946229935 seconds
#-------------- Test result --------------
#Test average MRR : 0.7295784809404308
#Test average MR : 23.274848475791213
#Test average HITS@1 : 0.6542958519036927
#Test average HITS@3 : 0.7759042484193683
#Test average HITS@10 : 0.8722217411367317
#-----------------------------------------
#testing takes 3682.333 seconds
##################################################

###Freebase86m_DistMult:
dglke_train --model_name DistMult --dataset Freebase --batch_size 1024 --neg_sample_size 256 \
--hidden_dim 400 --gamma 143.0 --lr 0.08 --batch_size_eval 1000 --test -adv --mix_cpu_gpu \
--num_proc 8 --gpu 0 1 --max_step 300000 --neg_sample_size_eval 1000 --eval_interval 100000 \ 
--log_interval 1000 --async_update --rel_part --force_sync_interval 10000 --num_thread 4 --no_save_emb &

################## Script Result #################
#training takes 4898.2239985466 seconds
#-------------- Test result --------------
#Test average MRR : 0.8334113070741931
#Test average MR : 45.544044121590794
#Test average HITS@1 : 0.8132268607789521
#Test average HITS@3 : 0.8425632045917057
#Test average HITS@10 : 0.8711637238805036
#-----------------------------------------
#testing takes 3777.678 seconds
##################################################

###Freebase86m_ComplEx:
dglke_train --model_name ComplEx --dataset Freebase --batch_size 1024 --neg_sample_size 256 \
--hidden_dim 400 --gamma 143.0 --lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 1000 \
--test -adv --mix_cpu_gpu --num_proc 8 --gpu 0 1 --max_step 360000 --neg_sample_size_eval 1000 --log_interval 1000 \
--async_update --rel_part --force_sync_interval 10000 --no_save_emb &

################## Script Result #################
training takes 6434.67949962616 seconds
-------------- Test result --------------
Test average MRR : 0.8350476460350464
Test average MR : 46.558354334388625
Test average HITS@1 : 0.8177202517669357
Test average HITS@3 : 0.8420723398735495
Test average HITS@10 : 0.8678930054317636
-----------------------------------------
testing takes 3861.581 seconds
##################################################

###Freebase86m_TransR:
################## Script Result #################
##################################################

###Freebase86m_RotatE:
################## Script Result #################
##################################################
