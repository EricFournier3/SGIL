import os
import re

fax_file_path = os.path.join("/data/Applications/GitScript/SGIL/FAX_STATUS_20200318_08H_26m.txt")
sgil_file_path = os.path.join("/data/Applications/GitScript/SGIL/export_20200318.txt")

envois_sgil = []
envois_fax = []


with open(fax_file_path) as fax_f:
    for line in fax_f:
        try:
            l = line.split('Rapport lab')[1]
            #print l
            envoi = re.search('#Env 00(\d+) ',l).group(1)
            #print "Envoi ",envoi
            envois_fax.append(envoi)
        except:
            print "Error fax",line

print "Nb VSIFAX list ", len(envois_fax)
envois_fax = set(envois_fax)
#print "FAX = ", envois_fax
print "Nb VSIFAX set ", len(envois_fax)


with open(sgil_file_path) as sgil_f:
    sgil_f.readline()
    for line in sgil_f:
        try:
            l = line.split('\t')
            envoi = l[3]
            #print "******** ",envoi, " -------- ",l
            #envoi = re.search('#Env 00(\d+) ',l).group(1)

            envois_sgil.append(envoi)
        except:
            print "Error sgil ",line

print "Nb SGIL list ", len(envois_sgil)
envois_sgil = set(envois_sgil)
#print "SGIL = ", envois_sgil, "   "
print "Nb SGIL set ", len(envois_sgil)



in_fax_notin_sgil = envois_fax - envois_sgil
print "In VSIFAX NOT IN SGIL ", in_fax_notin_sgil # ce sont des envois de la veille

in_sgil_notin_fax = envois_sgil - envois_fax
print "In SGIL NOT IN VSIFAX ", in_sgil_notin_fax # doit etre 0

