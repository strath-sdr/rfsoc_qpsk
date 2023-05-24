# library
import sys
import os
import shutil

# variables
package_name = os.path.basename(os.path.dirname(os.path.abspath(os.path.realpath(__file__))))
board_list = ['ZCU111', 'RFSoC2x2', 'RFSoC4x2', 'ZCU208', 'ZCU216']

# dialogue
help_dialogue = ''.join(['\r\nThe ', package_name, ' module accepts one of the following arguments:', '\r\n',
                         '* install : Installs the package notebooks and contents', '\r\n',
                         '* uninstall : Uninstalls the package notebooks and contents', '\r\n',
                         '* clean : Returns the package notebooks and contents to their original states', '\r\n',
                         '* help : Displays this dialogue', '\r\n'])

error_dialogue = '\r\nUnknown error occurred.\r\n'

# check arguments
args = sys.argv
if len(args) > 2:
    raise RuntimeError(help_dialogue)
    
arg = args[1]
if arg not in ['install', 'uninstall', 'clean', 'help']:
    raise ValueError(help_dialogue)
    
# define functions
def install():
    dst = get_notebook_dst()
    src = os.path.abspath(os.path.join(os.path.realpath(__file__), '..', 'notebooks'))
    if os.path.exists(dst):
        raise RuntimeError(''.join(['Package already installed. ',
                                    'Please uninstall package before reinstalling.\r\n']))
    if not os.path.exists(src):
        raise RuntimeError(''.join(['Path does not exist: ', src, '\r\n']))
    shutil.copytree(src, dst)
    logfile = os.path.abspath(os.path.join(os.path.realpath(__file__), '..', 'install.txt'))
    with open(logfile, 'w') as f:
        f.write(dst)

def uninstall():
    logfile = os.path.abspath(os.path.join(os.path.realpath(__file__), '..', 'install.txt'))
    if not os.path.exists(logfile):
        raise RuntimeError('Package does not have an install location. Nothing has been removed.\r\n')
    with open(logfile, 'r') as f:
        dst = f.readline()
    if not os.path.exists(dst):
        raise RuntimeError('Package is not installed. Nothing has been removed.\r\n')
    shutil.rmtree(dst)
    os.remove(logfile)

def clean():
    uninstall()
    install()

def get_notebook_dst():
    return os.path.join(os.environ['PYNQ_JUPYTER_NOTEBOOKS'], package_name)

# run script
if arg == 'install':
    install()
elif arg == 'uninstall':
    uninstall()
elif arg == 'clean':
    clean()
elif arg == 'help':
    print(help_dialogue)
else:
    raise RuntimeError(error_dialogue)
    