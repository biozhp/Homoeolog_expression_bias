import re
import argparse
parser = argparse.ArgumentParser(description="Author: Peng Zhao <pengzhao@nwafu.edu.cn>")
parser.add_argument('-i', type=str,help="inf1_name")
parser.add_argument('-g', type=str,help="inf2_name")
parser.add_argument('-o', type=str,help="output")
args = parser.parse_args()
inf1_name = args.i
inf2_name = args.g
ouf_name = args.o
inf1 = open(inf1_name,"r")
inf2 = open(inf2_name,"r")
ouf = open(ouf_name,"w")
dict = {}
for line1 in inf1:
    line1 = line1.replace("\n","")
    li1 = re.split("\t",line1)
    dict[li1[1]] = li1[2]
for line2 in inf2:
    line2 = line2.replace("\n","")
    li2 = re.split("\t",line2)
    if li2[1] in dict:
        if li2[2] == "down":
            eud = "-" + dict[li2[1]]
        if li2[2] == "up":
            eud = dict[li2[1]]
        ouf.write("%s\t%s\n" % (li2[1], eud))
