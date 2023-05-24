import os
from distutils.dir_util import copy_tree
from setuptools import find_packages, setup

class package_installer():
    def __init__(self,
                 name,
                 version,
                 description,
                 author,
                 email,
                 license,
                 url,
                 pynq_version,
                 board):
        
        args = locals()
        for key in args:
            if key != 'self':
                setattr(self, key, args[key])
        self.check_board()
        self.copy_projects()
        self.run_setup()

    def check_board(self):
        if not os.path.isdir(f'boards/{self.board}/{self.name}'):
            raise ValueError("Board {} is not supported.".format(self.board))
        if not os.path.isdir(os.environ['PYNQ_JUPYTER_NOTEBOOKS']):
            raise ValueError(
                "Directory {} does not exist.".format(os.environ['PYNQ_JUPYTER_NOTEBOOKS']))
        
    def copy_projects(self):
        cwd = os.getcwd()
        for prj in next(os.walk(os.path.join(cwd, 'boards', self.board)))[1]:
            temp_prj = os.path.join(cwd, 'boards', self.board, prj)
            for directory in next(os.walk(temp_prj))[1]:
                src = os.path.join(temp_prj, directory)
                dst = os.path.join(cwd, self.name, prj, directory)
                copy_tree(src, dst)

    def generate_pkg_dirs(self):
        data_files = []
        for directory in os.walk(os.path.join(os.getcwd(), self.name)):
            for file in directory[2]:
                data_files.append("".join([directory[0],"/",file]))
        return data_files

    def run_setup(self):
        setup(name=self.name,
              version=self.version,
              install_requires=[self.pynq_version],
              url=self.url,
              license=self.license,
              author=self.author,
              author_email=self.email,
              packages=find_packages(),
              package_data={'': self.generate_pkg_dirs()},
              description=self.description)

package_installer(name = "rfsoc_qpsk",
                  version = "1.4.5",
                  description  = "PYNQ example of using the RFSoC as a QPSK transceiver.",
                  author = "Craig Ramsay",
                  email = "craig.ramsay.100@strath.ac.uk",
                  license = "BSD 3-Clause License",
                  url = "https://github.com/strath-sdr/rfsoc_qpsk.git",
                  pynq_version = "pynq>=2.7",
                  board = os.environ['BOARD'])
