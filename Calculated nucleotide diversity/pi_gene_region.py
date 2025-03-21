## Author: Peng Zhao
## Email: biozhp@163.com
## Input files: chrX.ABD.vcf.gz all.gene.pos.txt
## Usages: python pi_promoter_region.py -i gene_list.txt

import re
import os
import argparse
parser = argparse.ArgumentParser(description='manual to this script')
parser.add_argument('-i', type=str)
args = parser.parse_args()
list_name = str(args.i)
inf = open(list_name,"r")
inf2 = open("all.gene.pos.txt","r")
dict_1 = {}
for line2 in inf2:
    line2 = line2.replace("\n","")
    li2 = re.split("\t",line2)
    dict_1[li2[3]] = str(li2[0]) + "&" + str(li2[1]) + "&" + str(li2[2])
for line in inf:
    line = line.replace("\n","")
    li = re.split("\t",line)
    gene_id = str(li[0])
    line3 = dict_1[gene_id]
    li3 = re.split("&",line3)
    snp_region = str(li3[0]) + ":" + str(li3[1]) + "-" + str(li3[2])
    vcf_file = str(li3[0]) + ".ABD.vcf.gz"
    vcf_output = "./gene/" + str(li[0]) + ".gene.vcf.gz"
    vcf_command = "bcftools filter " + str(vcf_file) + " --regions " + str(snp_region) + " > " + vcf_output
    os.system(vcf_command)
    vcf_th_command = "python ./Triads_vcf_th.py -vcf " + str(vcf_output)
    os.system(vcf_th_command)
    windows_size = int(li3[2]) - int(li3[1]) + 1
    pi_command = "vcftools --vcf " + str(vcf_output) + ".output --window-pi " + str(windows_size) + " --window-pi-step " + str(windows_size) + " --out ./pi/" + str(li[0]) + ".gene.pi"
    os.system(pi_command)
    touch_command = "touch " + str(list_name) + ".finish"
    os.system(touch_command)
