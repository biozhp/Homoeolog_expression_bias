import re
import argparse
parser = argparse.ArgumentParser(description="Author: Peng Zhao <pengzhao@nwafu.edu.cn>")
parser.add_argument('-i', type=str,help="traits")
parser.add_argument('-g', type=str,help="inf2_name")
parser.add_argument('-o', type=str,help="output")
args = parser.parse_args()
inf_name = args.i
inf2_name = args.g
ouf_name = args.o
inf = open(inf_name,"r")
inf2 = open(inf2_name,"r")
ouf = open(ouf_name,"w")
dict_1 = {}
for line in inf:
    line = line.replace("\n","")
    li = re.split("\t",line)
    dict_1[li[0]] = li[1]
for line2 in inf2:
    line2 = line2.replace("\n","")
    li2 = re.split(" ",line2)
    if li2[0] in dict_1:
        ouf.write("%s %s\n" % (line2,dict_1[li2[0]]))
    else:
        ouf.write("%s %s\n" % (line2,"-9"))
ouf.close()
