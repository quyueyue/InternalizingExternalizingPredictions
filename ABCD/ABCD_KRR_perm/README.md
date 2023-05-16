# Permutation testing for predictive accuracy in ABCD analyses

This folder contains code used to implement permutation testing to assess statistical significance of predictive accuracy for both single- and multi-KRR models. 

To implement permutation testing for single-KRR models, run `bash CBIG_TRBPC_KRR_perm_wrapper.sh -i /gpfs/milgram/project/holmes/yq222/FYP/ABCD_output_rs_KRR/ -b 33 -s all_score -n 500 -t 2000 -m singleKRR -g /gpfs/milgram/project/holmes/yq222/FYP/ABCD/site_id_list.txt -o /gpfs/milgram/project/holmes/yq222/FYP/permutation_2262/KRR/ -c Milgram`

To implement permutation testing for multi-KRR models, run `bash CBIG_TRBPC_KRR_perm_wrapper.sh -i /gpfs/milgram/project/holmes/yq222/FYP/FYP_output/ -b 33 -s all_score -n 500 -t 2000 -m multiKRR -g /gpfs/milgram/project/holmes/yq222/FYP/ABCD/site_id_list.txt -o /gpfs/milgram/project/holmes/yq222/FYP/permutation_2262/multiKRR/ -c Milgram`
