#
# Cookbook Name:: maven
# Recipe:: set_m2_home
#
# Copyright 2014, Jonathan Klinginsmith
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

maven_version = node["maven"]["version"]
maven_prefix = node["maven"]["prefix"]
m2_home = "#{maven_prefix}/apache-maven-#{maven_version}"

ruby_block "set-env-java-home" do
  block do
    ENV["M2_HOME"] = m2_home
  end
  not_if { ENV["M2_HOME"] == m2_home }
end

directory "/etc/profile.d" do
  mode 00755
end

file "/etc/profile.d/maven.sh" do
  content "export M2_HOME=#{m2_home}"
  mode 00755
end
