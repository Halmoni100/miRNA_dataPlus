'''
Created on Jun 4, 2015
@author: Christopher Hongå
'''
# Open miRNA names to list
with open('../../../misc_data/saved_processed_data_text.txt') as f:
    f_lines = f.read().splitlines()
    
# Create miRNA sequence dictionary
miRNA_seq_dict = dict()

# Iterate through each miRNA
for i in range(1,len(f_lines)):
    line = f_lines[i]
    contents = line.split('\t')
    