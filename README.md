# prostate_BCR_prediction

## Dataset description (training_data_three_Pca_cohorts.tsv)
We retrieved three different RNA-Seq datasets of radical prostatectomy specimens with the associated clinical features. The first dataset is from The Genome Cancer Atlas (TCGA) cohort in the Prostate Adenocarcinoma (PRAD) project. The second dataset (GSE54460) is from a cohort constituted by Long et al. and the third dataset was provided by Prof C. Collins from the Vancouver Prostate Cancer Center (VPCC).
training_data_three_Pca_cohorts.tsv reprensent the read counts of these datasets, processed with Trimmomatic and Kallisto. 

Quality of the BCR event data is dependent on patient clinical follow-up. A patient followed only a few weeks or months after surgery without showing BCR would be considered as a non-BCR case. These cases are a bias since the patient could have experienced a BCR event after the period of follow-up. Consequently, we discarded from our analysis the patients with no BCR whose follow-up was inferior to 60 months.

TCGA-PRAD dataset: Data from 498 samples were initially recovered from the PRAD project on the TCGA data portal (https://portal.gdc.cancer.gov/). According to the TCGA Research Network 131 samples must be discarded because of the presence of RNA degradation, as we did. We also ignored samples with less than 40% of tumor cells (column percent_tumor_cells in clinical file) and follow-up inferior to 60 months. We ended up with 52 samples after these filters.

GSE54460 dataset: The data were downloaded from NCBI website (GEO accession GSE54460) where sequencing and clinical data from 106 patients were recovered. After selecting cases with a minimum of 60 months of follow-up, we ended-up with 96 patients of whom 54 had a BCR. 

VPCC dataset: We obtained the raw fastq files and clinical data from 85 patients, available at European Nucleotide Archive of the EMBL-EBI under accession PRJEB6530. Patients treated with hormonal therapy before radical prostatectomy were removed because this treatment strongly alters RNA expression. After selecting patients for minimal follow-up we ended up with 23 patients of whom 5 experienced a BCR.


# Publication

Identification of a transcriptomic prognostic signature by machine learning using a combination of small cohorts of prostate cancer

Background: Determining which treatment to provide to men with prostate cancer (PCa) is a major challenge for clinicians. Currently, the clinical risk-stratification for PCa is based on clinico-pathological variables such as Gleason grade, stage and prostate-specific antigen (PSA) levels. But transcriptomic data have the potential to enable the development of more precise approaches to predict evolution of the disease. However, high quality RNA sequencing (RNA-seq) datasets along with clinical data with long follow-up allowing discovery of biochemical recurrence (BCR) biomarkers are small and rare. In this study, we propose a machine learning approach that is robust to batch effect and enables the discovery of highly predictive signatures despite using small datasets.
Methods: Gene expression data were extracted from three RNA-Seq datasets cumulating a total of 171 PCa patients. Data were reanalyzed using a unique pipeline to ensure uniformity. Using a machine learning approach, a total of 14 classifiers were tested with various parameters to identify the best model and gene signature to predict BCR.
Results: Using a random forest model, we have identified a signature composed of only three genes (JUN, HES4, PPDPF) predicting BCR with better accuracy (74.2%, BER=27%) than the clinico-pathological variables (69.2%, BER=32%) currently in use to predict PCa evolution. This score is in the range of the studies that predicted BCR in single-cohort with a higher number of patients. 
Conclusions: We showed that it is possible to merge and analyze different small and heterogeneous datasets altogether to obtain a better signature than if they were analyzed individually, thus reducing the need for very large cohorts. This study demonstrates the feasibility to regroup different small datasets in one larger to identify a predictive genomic signature that would benefit PCa patients.
