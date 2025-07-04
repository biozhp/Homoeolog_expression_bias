import re
import argparse
parser = argparse.ArgumentParser(description="Author: Peng Zhao <pengzhao@nwafu.edu.cn>")
parser.add_argument('-i', type=str,help="inf_name")
parser.add_argument('-g', type=str,help="gene_name")
parser.add_argument('-o', type=str,help="ouf_name")
args = parser.parse_args()
inf_name = args.i
gene_name = args.g
ouf_name = args.o
inf2 = open(inf_name,"r")
ouf = open(ouf_name,"w")
for line2 in inf2:
    line2 = line2.replace("\n","")
    li2 = re.split("\t| ",line2)
    if li2[0] != "chr":
        if float(li2[12]) < 2:
            ouf.write("%s\t%s\t%s\t%s\n" % (gene_name,li2[1],li2[12],li2[7]))
    else:
        ouf.write("%s\t%s\t%s\t%s\n" % ("gene","snp","pvalue","beta"))
