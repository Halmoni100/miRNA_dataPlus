'''
Created on Jun 4, 2015
@author: Christopher Hong
'''

# Open precursor names to list
with open('../../../misc_data/saved_precursor_names.txt') as f:
    precursor_names_list = f.read().splitlines()

# Define precursor info entry structure
class prec_seq_info():
    def __init__(self):
        self.indices = []
        self.sequence = ''
        self.accounted = False
        self.length = 0
        self.gc_num = 0
        self.gc_prop = 0
    def print_string(self):
        string = self.sequence +'\t'+ str(self.length) + \
            '\t'+ str(self.gc_num) +'\t'+ str(self.gc_prop)
        return (string)

# Create miRNA sequence dictionary
prec_seq_dict = dict()
# Add indices to miRNA sequence dictionary
i = 0
for name in precursor_names_list:
    if name not in prec_seq_dict.keys():
        entry = prec_seq_info()
        entry.indices.append(i)
        prec_seq_dict[name] = entry
    else:
        entry = prec_seq_dict.get(name)
        entry.indices.append(i)
    i += 1

# Get number of miRNAs
num_names = len(prec_seq_dict)

# Get .fa file
f = open('../../../sequence_data/precursor_withnovel.fa', 'r')

# analyze every 2 lines in .fa file
while True:
    line1 = f.readline()
    line2 = f.readline()
    seq = line2.strip()
    if (line1 == '>provisional id\n'):
        break
    # get rid of '>'
    name = line1[1:]
    # get rid of new line char
    name = name.strip()
    if name in prec_seq_dict.keys():
        info = prec_seq_dict.get(name)
        info.accounted = True
        info.sequence = seq
        info.length = len(seq)
        gc_content = 0
        for c in seq:
            if c=='G' or c=='C':
                gc_content += 1
        info.gc_num = gc_content
        info.gc_prop = gc_content / info.length

f.close()

# Check if all accounted for
all_accounted = True
for name in prec_seq_dict.keys():
    info = prec_seq_dict.get(name)
    all_accounted = all_accounted and info.accounted
if all_accounted:
    print('All precursor names accounted for')
    print('# precursor names: ' + str(num_names))
    num_keys = len(prec_seq_dict.keys())
    print('# keys in dict: ' + str(num_keys))
else:
    raise NameError('Not all miRNA names accounted for')

# Open file to write in
out = open('../../../Preliminary_steps/sequence_content/content_table_precursor.txt', 'w')

# Write results to file
# print header
print('precursor\tsequence\tlength\tgc_num\tgc_prop', file=out)
# print sequence info
for name in precursor_names_list:
    info = prec_seq_dict.get(name)
    print(name +'\t'+ info.print_string(), file=out)
    
out.close()
