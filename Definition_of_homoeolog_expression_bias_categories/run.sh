## sh run.sh K147
id=$1
mkdir ./temp/${id}/
python ./scripts/gene_list.py -s ${id} && \
cat ./temp/${id}/gene.list | while read line
do
cat ./scripts/header.txt ./dist_input/${id}/${line}".stand.txt" ./scripts/stand.txt > ./temp/${id}/dist_input.txt && \
Rscript ./scripts/dist_cal.R ./temp/${id}/ > ./temp/${id}/dist_cal.txt && \
sed -i '1d' ./temp/${id}/dist_cal.txt && \
awk -F " " '{print $1,$2}' ./temp/${id}/dist_cal.txt | head -n 7 > ./temp/${id}/dist_cal_temp.txt
sort -t " " -k2n,2 ./temp/${id}/dist_cal_temp.txt > ./temp/${id}/sort_min.txt && \
head -n 1 ./temp/${id}/sort_min.txt > ./temp/${id}/min.txt && \
python ./scripts/eud_min.py -i ./temp/${id}/min.txt -s ${id} -g ${line}
done
rm -r ./temp/${id}/
