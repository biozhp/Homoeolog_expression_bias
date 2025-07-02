import re
import argparse
parser = argparse.ArgumentParser(description="Author: Peng Zhao <pengzhao@nwafu.edu.cn>")
parser.add_argument('-i', type=str,help="inf_name")
parser.add_argument('-s', type=str,help="sample_name")
parser.add_argument('-g', type=str,help="gene_name")
args = parser.parse_args()
inf_name = args.i
sample_name = args.s
gene_name = args.g
inf = open(inf_name,"r")
for line in inf:
    line = line.replace("\n","")
    li = re.split("\t| ",line)
    print("%s%s%s\t%s" % (gene_name,"_",sample_name,li[0]))
