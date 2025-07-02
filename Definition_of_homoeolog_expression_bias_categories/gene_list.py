import re
import argparse
parser = argparse.ArgumentParser(description="Author: Peng Zhao <pengzhao@nwafu.edu.cn>")
parser.add_argument('-s', type=str,help="sample_name")
args = parser.parse_args()
sample_name = args.s
inf_name = "/stor9000/apps/users/NWSUAF/2017051475/Project/Triads_406/eud/all.sample.eud.txt"
ouf_name = "/stor9000/apps/users/NWSUAF/2017051475/Project/Triads_406/eud/temp/" + str(sample_name) + "/gene.list"
inf = open(inf_name,"r")
ouf = open(ouf_name,"w")
for line in inf:
    line = line.replace("\n","")
    li = re.split("\t|_| ",line)
    if str(li[1]) == str(sample_name):
        ouf.write("%s\n" % (li[0]))
ouf.close()
