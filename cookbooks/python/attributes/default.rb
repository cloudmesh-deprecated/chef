default["python"]["version"] = "2.7.6"
default["python"]["short_version"] = "#{node["python"]["version"][0,3]}"
default["python"]["download_url"] = "http://python.org/ftp/python/#{node["python"]["version"]}/Python-#{node["python"]["version"]}.tgz"
default["python"]["download_dir"] = "/tmp"
default["python"]["checksum"] = ""
default["python"]["prefix"] = "/usr/local"
default["python"]["install_method"] = "source"

default["python"]["cython_version"] = "0.19.2"
default["python"]["cython_download_url"] = "https://pypi.python.org/packages/source/C/Cython/Cython-#{node["python"]["cython_version"]}.tar.gz"
default["python"]["cython_checksum"] = "c5b55b0bd40e23a9cbcd2c1bdefe9771fc5836938acef772795813a6f6432c48"

default["python"]["distribute_setup_download_url"] = "http://python-distribute.org/distribute_setup.py"
default["python"]["distribute_setup_checksum"] = "974f342d4376551fbf08baec7556ead4f4bd1bca6b1a9c5bad5a0d8b88cee0fe"

default["python"]["ez_setup_download_url"] = "http://peak.telecommunity.com/dist/ez_setup.py"
default["python"]["ez_setup_checksum"] = "1912fa2575cf3ecbee1a97800d0df6acb6cb0f6eea76f9f20d632220ae476748"

default["python"]["imaging_version"] = "1.1.7"
default["python"]["imaging_download_url"] = "http://effbot.org/media/downloads/Imaging-#{node["python"]["imaging_version"]}.tar.gz"
default["python"]["imaging_checksum"] = "895bc7c2498c8e1f9b99938f1a40dc86b3f149741f105cf7c7bd2e0725405211"

default["python"]["matplotlib_version"] = "1.3.1"
default["python"]["matplotlib_download_url"] = "http://downloads.sourceforge.net/project/matplotlib/matplotlib/matplotlib-#{node["python"]["matplotlib_version"]}/matplotlib-#{node["python"]["matplotlib_version"]}.tar.gz"
default["python"]["matplotlib_checksum"] = "ea16679d9476ab2757102e80327f31eb8e6c2cb09e2be89715c02e4e8fbdaf6a"

default["python"]["mpi4py_version"] = "1.3.1"
default["python"]["mpi4py_download_url"] = "https://mpi4py.googlecode.com/files/mpi4py-#{node["python"]["mpi4py_version"]}.tar.gz"
default["python"]["mpi4py_checksum"] = "e7bd2044aaac5a6ea87a87b2ecc73b310bb6efe5026031e33067ea3c2efc3507"
default["python"]["mpi4py_mpi_prefix"] = "/usr/local"

default["python"]["numpy_version"] = "1.8.0"
default["python"]["numpy_download_url"] = "https://pypi.python.org/packages/source/n/numpy/numpy-#{node["python"]["numpy_version"]}.tar.gz"
default["python"]["numpy_checksum"] = "2764d0819acc77e9ff81b060fe7f69530b0d85c26ac9d162639b787cb227d253"

default["python"]["pandas_version"] = "0.12.0"
default["python"]["pandas_download_url"] = "https://pypi.python.org/packages/source/p/pandas/pandas-#{node["python"]["pandas_version"]}.tar.gz"
default["python"]["pandas_checksum"] = "be9b4c3611801b366873531bc87a87dd16b19e7d78fa84c21898cd007931c86d"

default["python"]["scipy_version"] = "0.13.2"
default["python"]["scipy_download_url"] = "http://downloads.sourceforge.net/project/scipy/scipy/#{node["python"]["scipy_version"]}/scipy-#{node["python"]["scipy_version"]}.tar.gz"
default["python"]["scipy_checksum"] = "485f194c7fe46da92e63bff524346ccaed4040c27df536bbde7b1edc9a07b449"

default["python"]["setuptools_setup_download_url"] = "https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py"
default["python"]["setuptools_setup_checksum"] = "8485d4534ffcef7ef1e726586da8a848f715066994ba84cf17bc5ae8f6f023d0"

default["python"]["tables_version"] = "3.0.0"
default["python"]["tables_download_url"] = "https://pypi.python.org/packages/source/t/tables/tables-#{node["python"]["tables_version"]}.tar.gz"
default["python"]["tables_checksum"] = "53532a59c8f03c3c5ef3c73c04f5bfd8384d6a3d508683cb87fc17af4c71dfe1"
default["python"]["tables_setup_options"] = ""
