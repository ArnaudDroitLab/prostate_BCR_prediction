# prostate_BCR_prediction

## dataset description
We retrieved three different RNA-Seq datasets of radical prostatectomy specimens with the associated clinical features. The first dataset is from The Genome Cancer Atlas (TCGA) cohort in the Prostate Adenocarcinoma (PRAD) project. The second dataset (GSE54460) is from a cohort constituted by Long et al. and the third dataset was provided by Prof C. Collins from the Vancouver Prostate Cancer Center (VPCC).

Quality of the BCR event data is dependent on patient clinical follow-up. A patient followed only a few weeks or months after surgery without showing BCR would be considered as a non-BCR case. These cases are a bias since the patient could have experienced a BCR event after the period of follow-up. Consequently, we discarded from our analysis the patients with no BCR whose follow-up was inferior to 60 months.

TCGA-PRAD dataset: Data from 498 samples were initially recovered from the PRAD project on the TCGA data portal (https://portal.gdc.cancer.gov/). According to the TCGA Research Network 131 samples must be discarded because of the presence of RNA degradation, as we did. We also ignored samples with less than 40% of tumor cells (column percent_tumor_cells in clinical file) and follow-up inferior to 60 months. We ended up with 52 samples after these filters.

GSE54460 dataset: The data were downloaded from NCBI website (GEO accession GSE54460) where sequencing and clinical data from 106 patients were recovered. After selecting cases with a minimum of 60 months of follow-up, we ended-up with 96 patients of whom 54 had a BCR. 

VPCC dataset: We obtained the raw fastq files and clinical data from 85 patients, available at European Nucleotide Archive of the EMBL-EBI under accession PRJEB6530. Patients treated with hormonal therapy before radical prostatectomy were removed because this treatment strongly alters RNA expression. After selecting patients for minimal follow-up we ended up with 23 patients of whom 5 experienced a BCR.
