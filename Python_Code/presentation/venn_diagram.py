import matplotlib
import matplotlib.pyplot as plt
from matplotlib_venn import venn2

font = {'family' : 'normal',
        'weight' : 'normal',
        'size'   : 18}

matplotlib.rc('font', **font)

def vennSig(sig1,sig2,lab1,lab2,title,file):
    plt.figure(figsize=(10,10))
    v = venn2([set(sig1),set(sig2)], set_labels = (lab1, lab2))
    plt.title(title)
    plt.savefig(file)


vs_v_bc = [83, 86, 165, 200, 201, 211]
vs_v_bls = [200, 201]
bc_v_bl = [18, 51, 86, 91, 109, 111, 141, 165, 191, 193, 199, 200, 201, 211, 319]

vennSig(vs_v_bc, vs_v_bls,'Viral Symp vs. Bacteria',
        'Viral Symp vs Baseline\nSymp',
        'Overlap of T-Test Significant miRNAs',
        'vs_v_bc_and_vs_v_bls_VennDiagram.png')
vennSig(vs_v_bc, bc_v_bl,'Viral Symp vs. Bacteria',
        'Bacteria vs. Baseline',
        'Overlap of T-Test Significant miRNAs',
        'vs_v_bc_and_bc_v_bl_VennDiagram.png')