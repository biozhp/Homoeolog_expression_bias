## sh gemma_A.sh TraesCS6A02G131700
line=$1
mkdir ./A/${line}/
mkdir ./A/${line}/${line}/
grep -w "${line}" ./file/A.txt >  ./A/${line}/${line}/gene_sample_type.txt
grep -w "${line}" dynamic.sample.200.eud.txt > ./A/${line}/${line}/gene_sample_eud.txt
python ./A/eud.py -i ./A/${line}/${line}/gene_sample_eud.txt -g ./A/${line}/${line}/gene_sample_type.txt -o ./A/${line}/${line}/gene_sample_type_eud.txt
awk '{print $1}' ./A/${line}/${line}/gene_sample_type_eud.txt > ./A/${line}/${line}/sample.txt
bcftools view -S ./A/${line}/${line}/sample.txt --min-af 0.1 -o ./A/${line}/${line}/new.vcf /storage/public/home/2014110088/Project/Triads/WMG199_CSDV418_snp.biallelic.miss_maf.filter.id_gt.CS.vcf.gz
plink --threads 3 --vcf ./A/${line}/${line}/new.vcf --allow-extra-chr --recode --out ./A/${line}/${line}/snp
plink --threads 3 --file ./A/${line}/${line}/snp --allow-extra-chr --make-bed --out ./A/${line}/${line}/snp_test
mv ./A/${line}/${line}/snp_test.fam ./A/${line}/sample.fam
awk '{print $1,$2,$3,$4,$5}' ./A/${line}/sample.fam > ./A/${line}/sample_1.fam
python ./A/fam.py -i ./A/${line}/${line}/gene_sample_type_eud.txt -g ./A/${line}/sample_1.fam -o ./A/${line}/${line}/snp_test.fam && \
./gemma-0.98.5-linux-static-AMD64 -bfile ./A/${line}/${line}/snp_test -gk 2 -o ${line}".gemma_A" && \
./gemma-0.98.5-linux-static-AMD64 -bfile ./A/${line}/${line}/snp_test -k ./output/${line}".gemma_A.sXX.txt" -lmm 4 -o ${line}".gemma_A" && \
python ./A/gene_name.py -i ./output/${line}".gemma_A.assoc.txt" -g ${line} -o ./A/${line}/${line}"_A_out.txt" && \
python ./A/p-value.py -i ./A/${line}/${line}"_A_out.txt" -g ./A/${line}/${line}/new.vcf -o ./A/result/${line}"_A_out.txt" && \
rm ./output/${line}".gemma_A.assoc.txt" ./output/${line}".gemma_A.sXX.txt"
rm -r ./A/${line}
