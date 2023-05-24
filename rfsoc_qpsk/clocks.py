import os
import xrfclk 

def _get_lmclk_devices():
    """Populate LMK and LMX devices.
    """
    
    # Search for devices if none exist
    if xrfclk.lmk_devices == [] and xrfclk.lmx_devices == []:
        xrfclk.xrfclk._find_devices()

def _get_custom_lmclks(loc):
    """Search for LMK and LMX clock files with a given address.
    """
    
    # Check type and value
    if not isinstance(loc, str):
        raise TypeError('Address location must be a string.')
    if not os.path.isdir(loc):
        raise ValueError('Address location does not exist.')
    
    # Variables
    lmk_loc = ''
    lmx_loc = ''
    lmclk_loc = ''
    
    # Walk through directory and find .txt files
    for root, dirs, files in os.walk(loc):
        for d in dirs:
            for lmk in xrfclk.lmk_devices:
                if d == lmk['compatible']:
                    lmclk_loc = os.path.join(root, d)
                    break
    
    # Check variable is empty
    if lmclk_loc == '':
        raise RuntimeError('Could not find lmclk files.')
    
    # Use root directory to extract LMK and LMX locs
    for file in os.listdir(lmclk_loc):
        if file.endswith('.txt'):
            if 'LMK' in file:
                lmk_loc = os.path.join(lmclk_loc, file)
            elif 'LMX' in file:
                lmx_loc = os.path.join(lmclk_loc, file)
            
    # Check variables are empty
    if lmk_loc == '' or lmx_loc == '':
        raise RuntimeError('Could not find lmclk files.')
            
    return lmk_loc, lmx_loc

def _get_custom_lmclk_props(lmk_loc, lmx_loc):
    """Obtain the properties for LMK and LMX clocks using
    a set of address locations for clock files.
    """
    
    # Check type, value, and file format
    if not isinstance(lmk_loc, str) or not isinstance(lmx_loc, str):
        raise TypeError('TICS files must be a string.')
    if not os.path.isfile(lmk_loc) or not os.path.isfile(lmx_loc):
        raise ValueError('TICS file paths do not exist.')
    if not lmk_loc[-4:] == '.txt' or not lmx_loc[-4:] == '.txt':
        raise ValueError('TICS files must be .txt files.')
    
    # Strip file name from arguments
    lmk_name = lmk_loc.split('/')[-1]
    lmx_name = lmx_loc.split('/')[-1]
    
    # Split file name into LMK and LMX chip and freq (strip .txt)
    lmk_split = lmk_name.strip('.txt').split('_')
    lmx_split = lmx_name.strip('.txt').split('_')
    
    # Obtain LMK and LMX chip and freq components and
    # check for errors in format
    if len(lmk_split) == 2 and len(lmx_split) == 2:
        lmk_chip, lmk_freq = lmk_split
        lmx_chip, lmx_freq = lmx_split
    else:
        raise ValueError('TICS file names have incorrect format.')
    
    # Open files and parse registers
    with open(lmk_loc, 'r') as file:
        reg = [line.rstrip("\n") for line in file]
        lmk_reg = [int(r.split('\t')[-1], 16) for r in reg]
    with open(lmx_loc, 'r') as file:
        reg = [line.rstrip("\n") for line in file]
        lmx_reg = [int(r.split('\t')[-1], 16) for r in reg]
        
    # Populate TICS file dictionary
    clk_props = {
        'lmk' : {
            'file' : lmk_name,
            'loc'  : lmk_loc,
            'chip' : lmk_chip,
            'freq' : lmk_freq,
            'reg'  : lmk_reg
        },
        'lmx' : {
            'file' : lmx_name,
            'loc'  : lmx_loc,
            'chip' : lmx_chip,
            'freq' : lmx_freq,
            'reg'  : lmx_reg
        }
    }
    
    return clk_props

def _program_custom_lmclks(clk_props):
    """Program the LMK and LMX clocks using clock properties.
    """
        
    # Program each device
    for lmk in xrfclk.lmk_devices:
        xrfclk.xrfclk._write_LMK_regs(clk_props['lmk']['reg'], lmk)
    for lmx in xrfclk.lmx_devices:
        xrfclk.xrfclk._write_LMX_regs(clk_props['lmx']['reg'], lmx)

def set_custom_lmclks():
    """Populate LMK and LMX clocks. Search for clock files.
    Obtain the properties of the clock files. Program the
    LMK and LMX clocks with the properties of the files.
    """
    
    # Ensure LMK and LMX devices are known
    _get_lmclk_devices()
    
    # Get custom ref clock locs
    cwd = os.getcwd()
    lmk_loc, lmx_loc = _get_custom_lmclks(cwd)
    
    # Get custom ref clock props
    clk_props = _get_custom_lmclk_props(lmk_loc, lmx_loc)
    
    # Program custom ref clocks
    _program_custom_lmclks(clk_props)
        