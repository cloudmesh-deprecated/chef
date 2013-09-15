default["python"]["version"] = "2.7.5"
default["python"]["short_version"] = "#{node["python"]["version"][0,3]}"
default["python"]["download_url"] = "http://python.org/ftp/python/#{node["python"]["version"]}/Python-#{node["python"]["version"]}.tar.bz2"
default["python"]["download_dir"] = "/tmp"
default["python"]["checksum"] = "3b477554864e616a041ee4d7cef9849751770bc7c39adaf78a94ea145c488059"
default["python"]["prefix"] = "/usr/local"
default["python"]["install_method"] = "source"

default["python"]["cython_version"] = "0.19.1"
default["python"]["cython_download_url"] = "https://pypi.python.org/packages/source/C/Cython/Cython-#{node["python"]["cython_version"]}.tar.gz"
default["python"]["cython_checksum"] = "0b90aaa286acdd1bf75a6dd144dfc45192f011f2c2401cf5f80ed6ab5f8bf778"

default["python"]["distribute_setup_download_url"] = "http://python-distribute.org/distribute_setup.py"
default["python"]["distribute_setup_checksum"] = "974f342d4376551fbf08baec7556ead4f4bd1bca6b1a9c5bad5a0d8b88cee0fe"

default["python"]["ez_setup_download_url"] = "http://peak.telecommunity.com/dist/ez_setup.py"
default["python"]["ez_setup_checksum"] = "1912fa2575cf3ecbee1a97800d0df6acb6cb0f6eea76f9f20d632220ae476748"

default["python"]["imaging_version"] = "1.1.7"
default["python"]["imaging_download_url"] = "http://effbot.org/media/downloads/Imaging-#{node["python"]["imaging_version"]}.tar.gz"
default["python"]["imaging_checksum"] = "895bc7c2498c8e1f9b99938f1a40dc86b3f149741f105cf7c7bd2e0725405211"

default["python"]["matplotlib_version"] = "1.3.0"
default["python"]["matplotlib_download_url"] = "http://downloads.sourceforge.net/project/matplotlib/matplotlib/matplotlib-#{node["python"]["matplotlib_version"]}/matplotlib-#{node["python"]["matplotlib_version"]}.tar.gz"
default["python"]["matplotlib_checksum"] = "3e37044911245d7d881ddab0152cfec463c597b9a207c7f87021b8f40e1cbd98"

default["python"]["mpi4py_version"] = "1.3.1"
default["python"]["mpi4py_download_url"] = "https://mpi4py.googlecode.com/files/mpi4py-#{node["python"]["mpi4py_version"]}.tar.gz"
default["python"]["mpi4py_checksum"] = "e7bd2044aaac5a6ea87a87b2ecc73b310bb6efe5026031e33067ea3c2efc3507"
default["python"]["mpi4py_mpi_prefix"] = "/usr/local"

default["python"]["numpy_version"] = "1.7.1"
default["python"]["numpy_download_url"] = "https://pypi.python.org/packages/source/n/numpy/numpy-#{node["python"]["numpy_version"]}.tar.gz"
default["python"]["numpy_checksum"] = "5525019a3085c3d860e6cfe4c0a30fb65d567626aafc50cf1252a641a418084a"

default["python"]["pandas_version"] = "0.12.0"
default["python"]["pandas_download_url"] = "https://pypi.python.org/packages/source/p/pandas/pandas-#{node["python"]["pandas_version"]}.tar.gz"
default["python"]["pandas_checksum"] = ""

default["python"]["scipy_version"] = "0.12.0"
default["python"]["scipy_download_url"] = "http://downloads.sourceforge.net/project/scipy/scipy/#{node["python"]["scipy_version"]}/scipy-#{node["python"]["scipy_version"]}.tar.gz"
default["python"]["scipy_checksum"] = "b967e802dafe2db043cfbdf0043e1312f9ce9c1386863e1c801a08ddfccf9de6"

default["python"]["tables_version"] = "3.0.0"
default["python"]["tables_download_url"] = "https://pypi.python.org/packages/source/t/tables/tables-#{node["python"]["tables_version"]}.tar.gz"
default["python"]["tables_checksum"] = "53532a59c8f03c3c5ef3c73c04f5bfd8384d6a3d508683cb87fc17af4c71dfe1"
default["python"]["tables_setup_options"] = ""
