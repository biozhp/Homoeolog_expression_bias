## sh pve.sh chr1D_33708187 TraesCS7D02G111600
snp=$1
gene=$2 
mkdir -p $snp"."$gene
awk -v gene="$gene" 'NR==1 || $1 == gene' qqnorm.exp.txt > $snp"."$gene"/gene_exp.txt"
awk -v snp="$snp" 'NR==1 || $3 == snp' snp.info.txt > $snp"."$gene"/snp_info.txt"
awk '{for (i=1; i<=NF; i++) col[i]=col[i] $i " "} END {for (i=1; i<=NF; i++) print col[i]}' $snp"."$gene"/gene_exp.txt" | sed 's/[ \t]*$//g' > $snp"."$gene"/tpm_transposed.txt"
awk '{for (i=1; i<=NF; i++) col[i]=col[i] $i " "} END {for (i=1; i<=NF; i++) print col[i]}' $snp"."$gene"/snp_info.txt" | sed 's/[ \t]*$//g' > $snp"."$gene"/snp_transposed.txt"
LANG=en_EN sort $snp"."$gene"/tpm_transposed.txt" > $snp"."$gene"/tpm_sorted.txt"
LANG=en_EN sort $snp"."$gene"/snp_transposed.txt" > $snp"."$gene"/snp_sorted.txt"
LANG=en_EN join $snp"."$gene"/tpm_sorted.txt" $snp"."$gene"/snp_sorted.txt" > $snp"."$gene"/TPM_SNP.txt"
LANG=en_EN join $snp"."$gene"/TPM_SNP.txt" cov.txt > $snp"."$gene"/TPM_SNP_cov.txt"
cat $snp"."$gene"/TPM_SNP_cov.txt" | tr " " "\t" > $snp"."$gene"/TPM_SNP_cov_1.txt"
cat input_header.txt $snp"."$gene"/TPM_SNP_cov_1.txt" > $snp"."$gene"/input.txt"
Rscript pve.R  $snp"."$gene > $snp"."$gene"/pve.txt"
awk -v snp="$snp" -v gene="$gene" '{print $0 "\t" snp "\t" gene}' $snp"."$gene"/pve.txt" > result/$snp"."$gene".txt"
rm -r $snp"."$gene
