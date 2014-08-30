default["python"]["version"] = "2.7.8"
default["python"]["short_version"] = "#{node["python"]["version"][0,3]}"
default["python"]["download_url"] = "https://www.python.org/ftp/python/#{node["python"]["version"]}/Python-#{node["python"]["version"]}.tgz"
default["python"]["download_dir"] = "/tmp"
default["python"]["checksum"] = "74d70b914da4487aa1d97222b29e9554d042f825f26cb2b93abd20fdda56b557"
default["python"]["prefix"] = "/usr/local"
default["python"]["install_method"] = "source"

default["python"]["cython_version"] = "0.20.2"
default["python"]["cython_download_url"] = "https://pypi.python.org/packages/source/C/Cython/Cython-#{node["python"]["cython_version"]}.tar.gz"
default["python"]["cython_checksum"] = "31a563744a21d7b10355f25a3bca96b37ec5d32bdecfc75e93d65a5f7e62766c"

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

default["python"]["numpy_version"] = "1.8.2"
default["python"]["numpy_download_url"] = "https://pypi.python.org/packages/source/n/numpy/numpy-#{node["python"]["numpy_version"]}.tar.gz"
default["python"]["numpy_checksum"] = "6d487fc724780d66746bde264ea71f5cd77d3a39e52ee2b073dcaed63bc669db"

default["python"]["pandas_version"] = "0.13.1"
default["python"]["pandas_download_url"] = "https://pypi.python.org/packages/source/p/pandas/pandas-#{node["python"]["pandas_version"]}.tar.gz"
default["python"]["pandas_checksum"] = "6813746caa796550969ed98069f16627f070f6d8d60686cfb3fa0e66c2e0312b"

default["python"]["pip_get-pip_url"] = "https://bootstrap.pypa.io/get-pip.py"
default["python"]["pip_get-pip_checkum"] = "d43dc33a5670d69dd14a9be1f2b2fa27ebf124ec1b212a47425331040f742a9b"

default["python"]["scipy_version"] = "0.14.0"
default["python"]["scipy_download_url"] = "http://downloads.sourceforge.net/project/scipy/scipy/#{node["python"]["scipy_version"]}/scipy-#{node["python"]["scipy_version"]}.tar.gz"
default["python"]["scipy_checksum"] = "4b41a3e6bf178df1c7f0ef3bfeabf1f56610329aca5dbd7b6d64da8ac9af6b14"

default["python"]["setuptools_setup_download_url"] = "https://bootstrap.pypa.io/ez_setup.py"
default["python"]["setuptools_setup_checksum"] = "97cbf7f590e79613b245d30de7949d57e801ca149aa138a558863be8e29eb18c"

default["python"]["tables_version"] = "3.1.1"
default["python"]["tables_download_url"] = "https://pypi.python.org/packages/source/t/tables/tables-#{node["python"]["tables_version"]}.tar.gz"
default["python"]["tables_checksum"] = "39b9036376f1185599771c19276f13b5b9119d98f9108f58595745ded3fe2da3"
default["python"]["tables_setup_options"] = ""
