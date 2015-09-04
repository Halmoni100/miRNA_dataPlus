
import matplotlib
import matplotlib.pyplot as plt
from matplotlib_venn import venn3

font = {'family' : 'normal',
        'weight' : 'normal',
        'size'   : 18}

matplotlib.rc('font', **font)

def vennSig(sig1,sig2,sig3, lab1,lab2, lab3, title,file):
    plt.figure(figsize=(10,12))
    v = venn3([set(sig1),set(sig2), set(sig3)], set_labels = (lab1, lab2, lab3))
    plt.title(title)
    plt.savefig(file)


vs_v_bc = [83, 86, 165, 200, 201, 211]
vs_v_bls = [200, 201]
bc_v_bl = [18, 51, 86, 91, 109, 111, 141, 165, 191, 193, 199, 200, 201, 211, 319]

vennSig(vs_v_bc, vs_v_bls, bc_v_bl, 'Viral Symp\nvs. Bacteria',
        'Viral Symp\nvs Baseline Symp', 'Bacteria\nvs. Baseline',
        'Overlap of T-Test\nSignificant miRNAs',
        'triple_venn.png')