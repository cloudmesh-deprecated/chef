default["ipython"]["user"] = "ipynb"
default["ipython"]["group"] = "ipynb"
default["ipython"]["home_dir"] = "/home/#{node["ipython"]["user"]}"

default["ipython"]["profile_name"] = "nbserver"
default["ipython"]["profile_dir"] = "#{node["ipython"]["home_dir"]}/.ipython/profile_#{node["ipython"]["profile_name"]}"
default["ipython"]["notebook_password"] = ""
