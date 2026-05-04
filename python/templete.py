#!/bin/env python3
import os
import sys
from pathlib import Path

script_path = os.path.dirname(os.path.abspath(__file__))
save_path = os.path.abspath(os.path.join(script_path, '../images'))
output_name = Path(__file__).stem

def main(argv):
  savepdf = False
  savesvg = False
  quiet = False
  if "savepdf" in argv:
    savepdf = True
  if "savesvg" in argv:
    savesvg = True
  if "quiet" in argv:
    quiet = True
  
  save_pdf_file = os.path.join(save_path, f'{output_name}.pdf')
  save_svg_file = os.path.join(save_path, f'{output_name}.svg')

  # Plotting
  import matplotlib as mpl
  import matplotlib.pyplot as plt
  mpl.rcParams['svg.fonttype'] = 'none'
  # ...
  plt.plot([1,2,3,4])
  # ...

  if not quiet:
    print('Show plot...')
    plt.show() # quiet means plt.show() will not be called
  
  if savepdf:
    print('Save to %s' % save_pdf_file)
    plt.savefig(save_pdf_file, bbox_inches='tight')

  if savesvg:
    print('Save to %s' % save_svg_file)
    plt.savefig(save_svg_file, format='svg', bbox_inches='tight')

if __name__ == '__main__':
  if "help" in sys.argv:
    file_name = os.path.basename(__file__)
    print('Usage: python3 %s [savepdf] [savesvg] [quiet]' % file_name)
    exit(0)
  else:
    main(sys.argv[1:])
