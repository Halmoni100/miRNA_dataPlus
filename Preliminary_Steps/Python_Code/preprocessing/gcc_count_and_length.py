'''
Created on Jun 1, 2015
@author: Christopher Hong
'''

# Open miRNA names to list
with open('../../../misc_data/saved_miRNA_names.txt') as f:
    miRNA_names = f.readlines()
# Get number of miRNAs
num_names = len(miRNA_names)
# Get .fa file
f = open('../../../sequence_data/mature_withnovel.fa', 'r')
# Initialize output array of strings
out_array = ["" for i in range(num_names)]
# Initialize boolean array to check if all miRNA names were accounted for
accounted_array = [False for i in range(num_names)]
# Open file to write in
out = open('../../../Preliminary_steps/sequence_content/content_table.txt', 'w')

# analyze every 2 lines in .fa file
while True:
    line1 = f.readline()
    line2 = f.readline()
    if (line1 == '>provisional id'):
        break
    # get rid of '>'
    name = line1[1:]
    name_found = False
    name_index = 0
    for i in range(0,num_names):
        if name == miRNA_names[i]:
            name_found = True
            name_index = i
            break
    if name_found:
        seq_length = len(line2)
        gc_content = 0
        for c in line2:
            if c=='G' | c=='C':
                gc_content += 1
        line_out = seq_length + '\t' + gc_content
        out_array[name_index] = line_out
        accounted_array[name_index] = True

# Check if all accounted for
all_accounted = True
for accounted in accounted_array:
    all_accounted = accounted | bool
if all_accounted:
    print('All miRNA names accounted for')

# Write output        
for string in out_array:
    print(string, file=out)
    
f.close()
out.close()
