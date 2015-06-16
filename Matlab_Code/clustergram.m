% Load the following...
% quantile normalized data
quant_norm = csvread('../Data_in/quantile_norm_data.csv');
% miRNA names
f = fopen('../Data_in/miRNA_names_proc.txt');
miRNA_names = textscan(f, '%s', 'delimiter', '\n');
fclose(f);
miRNA_names = miRNA_names{1};
% factors vector
f = fopen('../Data_in/sample_factors.txt');
categories = textscan(f, '%s', 'delimiter', '\n');
fclose(f);
categories = categories{1};

CGobj = clustergram(quant_norm, 'RowLabels', miRNA_names, 'ColumnLabels', categories);



