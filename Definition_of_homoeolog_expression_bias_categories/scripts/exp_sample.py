import re
import argparse
parser = argparse.ArgumentParser(description="Author: Peng Zhao <pengzhao@nwafu.edu.cn>")
parser.add_argument('-s', type=str,help="sample")
args = parser.parse_args()
sample = args.s
inf_name = "./TPM_normal/Triads_" + str(sample) + ".txt"
inf2 = open("./scripts/test2.txt","r")
dict_1 = {}
for line2 in inf2:
    line2 = line2.replace("\n","")
    li2 = re.split("\t",line2)
    dict_1[li2[0]] = "1"
inf = open(inf_name,"r")
ouf2_name = "./temp/" + str(sample) + "/" + "gene.list"
ouf2 = open(ouf2_name, "w")
for line in inf:
    line = line.replace("\n","")
    li = re.split("\t| ",line)
    if str(li[3]) == "syntenic":
        if li[0] in dict_1:
            ouf_name = "./dist_input/" + str(sample) + "/" + str(li[0]) + ".stand.txt"
            ouf = open(ouf_name, "w")
            ouf.write("%s%s%s\t%s\t%s\t%s\n" % (li[0],"_",sample,li[7],li[8],li[9]))
            ouf2.write("%s\n" % (li[0]))
