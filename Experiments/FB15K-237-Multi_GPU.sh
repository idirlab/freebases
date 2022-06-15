
###FB15K-237-TransE_l2:
dglke_train --model_name TransE_l2 --dataset FB15k --batch_size 1000 --log_interval 1000 \
--neg_sample_size 200 --regularization_coef=1e-9 --hidden_dim 400 --gamma 19.9 \
--lr 0.25 --batch_size_eval 16 --test -adv --gpu 0 --max_step 3000 --mix_cpu_gpu --num_thread 4 \
--num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000--delimiter ,	

################## Script Result #################
#training takes 57.53517270088196 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.2495608430168987			
#Test average MR : 247.62750415322975			
#Test average HITS@1 : 0.15098211668132513			
#Test average HITS@3 : 0.28449623766246457			
#Test average HITS@10 : 0.44581256718459883			
#-----------------------------------------			
#testing takes 76.156 seconds			
##################################################

###FB15K-237-DistMult:
dglke_train --model_name DistMult --dataset FB15k-237 --batch_size 1000 --log_interval 1000 --neg_sample_size \
200 --hidden_dim 400 --gamma 143.0 --lr 0.08 --batch_size_eval 16 --test -adv --max_step 3000 --mix_cpu_gpu --num_proc 8 --num_thread 4 \
--gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter , 

################## Script Result #################
#training takes 54.469181537628174 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.2471953773915844			
#Test average MR : 386.749438092446			
#Test average HITS@1 : 0.15142187041923189			
#Test average HITS@3 : 0.2798543926512264			
#Test average HITS@10 : 0.4440291214697547			
#-----------------------------------------			
#testing takes 81.658 seconds			
##################################################

###FB15K-237-ComplEx:
dglke_train --model_name ComplEx --dataset FB15k-237 --batch_size 1000 --log_interval 1000 --neg_sample_size 200 \
--hidden_dim 400 --gamma 143.0 --lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 16 --test -adv --max_step 3000 \
--mix_cpu_gpu --num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter ,


################## Script Result #################
#training takes 58.731587171554565 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.24062683721836778			
#Test average MR : 404.19603244405357			
#Test average HITS@1 : 0.15010260920551158			
#Test average HITS@3 : 0.26876282615068897			
#Test average HITS@10 : 0.4269520179810417			
#-----------------------------------------			
#testing takes 87.383 seconds			
##################################################

###FB15K-237-TransR:
dglke_train --model_name TransR --dataset FB15k-237 --batch_size 1000 --log_interval 1000 --neg_sample_size 200 \
--regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.015 --batch_size_eval 16 --test -adv --max_step 3000 --mix_cpu_gpu --num_proc 8 \
--gpu 0 1 --async_update --rel_part --num_thread 4 --force_sync_interval 1000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 309.26077699661255 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.5763633330655789			
#Test average MR : 196.99479624743478			
#Test average HITS@1 : 0.5276556239616925			
#Test average HITS@3 : 0.5940828691488322			
#Test average HITS@10 : 0.6715283885468583			
#-----------------------------------------			
#testing takes 80.592 seconds			
##################################################

###FB15K-237-RotatE:
dglke_train --model_name RotatE --dataset FB15k-237 --batch_size 1024 --log_interval 1000 --neg_sample_size 256 \
--regularization_coef 1e-07 --hidden_dim 200 --gamma 12.0 --lr 0.009 --batch_size_eval 16 --test -adv -de --max_step 2500 --num_thread 4 \
--neg_deg_sample --mix_cpu_gpu --num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 404.9888319969177 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.24807081837126457			
#Test average MR : 288.63019153718363			
#Test average HITS@1 : 0.1607544219681423			
#Test average HITS@3 : 0.27115704094595916			
#Test average HITS@10 : 0.42643897195348385			
#-----------------------------------------			
#testing takes 88.686 seconds			
##################################################

