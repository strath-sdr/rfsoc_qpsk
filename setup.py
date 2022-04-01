import os
import shutil
from distutils.dir_util import copy_tree

from setuptools import find_packages, setup

# global variables
package_name = 'rfsoc_qpsk'
pip_name = 'rfsoc-qpsk'
board = os.environ['BOARD']
repo_board_folder = f'boards/{board}/{package_name}'
board_notebooks_dir = os.environ['PYNQ_JUPYTER_NOTEBOOKS']
board_project_dir = os.path.join(board_notebooks_dir, 'rfsoc-studio', 'qpsk-demonstrator')

data_files = []

# check whether board is supported
def check_env():
    if not os.path.isdir(repo_board_folder):
        raise ValueError("Board {} is not supported.".format(board))
    if not os.path.isdir(board_notebooks_dir):
        raise ValueError(
            "Directory {} does not exist.".format(board_notebooks_dir))


# copy overlays to python package
def copy_overlays():
    src_ol_dir = os.path.join(repo_board_folder, 'bitstream')
    dst_ol_dir = os.path.join(package_name, 'bitstream')
    copy_tree(src_ol_dir, dst_ol_dir)
    data_files.extend(
        [os.path.join("..", dst_ol_dir, f) for f in os.listdir(dst_ol_dir)])


# copy notebooks to jupyter home
def copy_notebooks():
    src_nb_dir = os.path.join(repo_board_folder, 'notebooks')
    dst_nb_dir = os.path.join(board_project_dir)
    if os.path.exists(dst_nb_dir):
        shutil.rmtree(dst_nb_dir)
    copy_tree(src_nb_dir, dst_nb_dir)


# copy driver to python package
def copy_drivers():
    src_dr_dir = os.path.join(repo_board_folder, 'drivers')
    dst_dr_dir = os.path.join(package_name)
    copy_tree(src_dr_dir, dst_dr_dir)
    data_files.extend(
        [os.path.join("..", dst_dr_dir, f) for f in os.listdir(dst_dr_dir)])


check_env()
copy_overlays()
copy_drivers()
copy_notebooks()


setup(
    name="rfsoc_qpsk",
    version='1.4.2',
    install_requires=[
        'pynq==2.7',
    ],
    url='https://github.com/strath-sdr/rfsoc_qpsk.git',
    license='BSD 3-Clause License',
    author="Craig Ramsay",
    author_email="craig.ramsay.100@strath.ac.uk",
    packages=find_packages(),
    package_data={
        '': data_files,
    },
    description="PYNQ example of using the RFSoC as a QPSK transceiver")
