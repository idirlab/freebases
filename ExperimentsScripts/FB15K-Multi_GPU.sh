###FB15K-TransE_l2:
dglke_train --model_name TransE_l2 --dataset FB15k --batch_size 1000 --log_interval 1000 \
--neg_sample_size 200 --regularization_coef=1e-9 --hidden_dim 400 --gamma 19.9 \
--lr 0.25 --batch_size_eval 16 --test -adv --gpu 0 --max_step 3000 --mix_cpu_gpu --num_thread 4 \
--num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000--delimiter ,

################## Script Result #################
#training takes 47.62875819206238 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.6399977929509036			
#Test average MR : 45.805352880432025			
#Test average HITS@1 : 0.5092431142184829			
#Test average HITS@3 : 0.7421662067681265			
#Test average HITS@10 : 0.8443483265900357			
#-----------------------------------------			
#testing takes 258.582 seconds			
##################################################

###FB15K-DistMult:
dglke_train --model_name DistMult --dataset FB15k --batch_size 1000 --log_interval 1000 \
--neg_sample_size 200 --hidden_dim 400 --gamma 143.0 --lr 0.08 --batch_size_eval 16 --test -adv --max_step 3000 --mix_cpu_gpu \
--num_proc 8 --num_thread 4 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 44.921332120895386 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.6774676318651275			
#Test average MR : 59.240244790167765			
#Test average HITS@1 : 0.5625010580487887			
#Test average HITS@3 : 0.7662389328096697			
#Test average HITS@10 : 0.8670244282304346			
#-----------------------------------------			
#testing takes 228.193 seconds			
##################################################

###FB15K-ComplEx:
dglke_train --model_name ComplEx --dataset FB15k --batch_size 1000 --log_interval 1000 \
--neg_sample_size 200 --hidden_dim 400 --gamma 143.0 --lr 0.1 --num_thread 4 --regularization_coef 2.00E-06 --batch_size_eval 16 \
--test -adv --max_step 3000 --mix_cpu_gpu --num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 49.7911434173584 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.7471189373993448			
#Test average MR : 64.8760813258621			
#Test average HITS@1 : 0.6640906705490004			
#Test average HITS@3 : 0.8098728648575443			
#Test average HITS@10 : 0.8819386839565946			
#-----------------------------------------			
#testing takes 225.716 seconds			
##################################################

###FB15K-TransR:
dglke_train --model_name TransR --dataset FB15k --batch_size 1000 --log_interval 1000 \
--neg_sample_size 200 --regularization_coef 5e-8 --hidden_dim 200 --gamma 8.0 --lr 0.015 --batch_size_eval 16 --test -adv --max_step 3000 \
--mix_cpu_gpu --num_proc 8 --gpu 0 1 --async_update --rel_part --num_thread 4 --force_sync_interval 1000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 278.10438895225525 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.6662812613657445			
#Test average MR : 67.37129048094666			
#Test average HITS@1 : 0.581842189907061			
#Test average HITS@3 : 0.723375260280002			
#Test average HITS@10 : 0.8026019535812835			
#-----------------------------------------			
#testing takes 261.882 seconds			
##################################################

###FB15K-RotatE:
dglke_train --model_name RotatE --dataset FB15k --batch_size 1024 --log_interval 1000 --neg_sample_size 256 \
--regularization_coef 1e-07 --hidden_dim 200 --gamma 12.0 --lr 0.009 --batch_size_eval 16 --test -adv -de --max_step 2500 --num_thread 4 \
--neg_deg_sample --mix_cpu_gpu --num_proc 8 --gpu 0 1 --async_update --rel_part --force_sync_interval 1000 --no_save_emb --delimiter ,

################## Script Result #################
#training takes 402.44253730773926 seconds			
#-------------- Test result --------------			
#Test average MRR : 0.6852603486789681			
#Test average MR : 50.20261211084966			
#Test average HITS@1 : 0.5828663811345669			
#Test average HITS@3 : 0.7611349054527602			
#Test average HITS@10 : 0.849477747117875			
#-----------------------------------------			
#testing takes 267.711 seconds			
##################################################
