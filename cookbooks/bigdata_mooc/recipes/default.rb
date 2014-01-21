#
# Cookbook Name:: bigdata_mooc
# Recipe:: default
#
# Copyright 2013, Jonathan Klinginsmith
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

bigdata_mooc_tmp_dir = node["bigdata_mooc"]["tmp_dir"]
bigdata_mooc_repo_url = node["bigdata_mooc"]["repo_url"]
dest_dir = "/home/ipynb"
bigdata_mooc_notebook_dir = node["bigdata_mooc"]["notebook_dir"]
bigdata_mooc_user = node["bigdata_mooc"]["user"]
bigdata_mooc_group = node["bigdata_mooc"]["group"]

packages = %w[git rsync]

packages.each do |package|
  package "#{package}" do
    action :install
  end
end

git "#{bigdata_mooc_tmp_dir}" do
  repository "#{bigdata_mooc_repo_url}"
  reference "master"
  action :sync
end

script "install IPython notebooks" do
  interpreter "bash"
  cwd "#{bigdata_mooc_tmp_dir}"
  code <<-EOH
  rsync --ignore-existing #{bigdata_mooc_tmp_dir}/*.ipynb #{bigdata_mooc_notebook_dir}
  chown #{bigdata_mooc_user}:#{bigdata_mooc_group} #{dest_dir}/*.ipynb
  EOH
  not_if "ls -l #{bigdata_mooc_notebook_dir}/*.ipynb > /dev/null 2>&1"
end

git_hash = { "/home/ipynb/java" => "https://github.com/cglmoocs/JavaFiles.git",
             "/home/ipynb/python" => "https://github.com/cglmoocs/PythonFiles.git",
             "/home/ipynb/dependencies" => "https://github.com/cglmoocs/Dependencies.git"}
git_hash.each do |git_dir, git_repo|
  git "#{git_dir}" do
    repository "#{git_repo}"
    reference "master"
    action :sync
  end
end

dependencies_dir = "/home/ipynb/dependencies"
ruby_block "set-env-classpath" do
  block do
    ENV["CLASSPATH"] = "#{ENV["CLASSPATH"]}:#{dependencies_dir}/*"
  end
  not_if { (ENV["CLASSPATH"].split(':').map { |directory| directory.eql?("#{dependencies_dir}/*") }).reduce{|r,e| r || e} }
end

directory "/etc/profile.d" do
  mode 00755
end

file "/etc/profile.d/mooc_dependencies.sh" do
  content "export CLASSPATH=${CLASSPATH}:#{dependencies_dir}/*"
  mode 00755
end
