#
# Cookbook Name:: uchiwa
# Recipe:: install
#
# Copyright (C) 2014 Jean-Francois Theroux
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Hipster stuff
include_recipe 'nodejs::install_from_binary'

# Use the source Luke!
package 'git'

directory "#{node['uchiwa']['base_dir']}-#{node['uchiwa']['version']}" do
  user node['uchiwa']['user']
  group node['uchiwa']['group']
end

git "#{node['uchiwa']['base_dir']}-#{node['uchiwa']['version']}" do
  repository 'https://github.com/palourde/uchiwa.git'
  reference node['uchiwa']['version']
  user node['uchiwa']['user']
  group node['uchiwa']['group']
  notifies :run, 'execute[run npm install]'
end

link node['uchiwa']['base_dir'] do
  to "#{node['uchiwa']['base_dir']}-#{node['uchiwa']['version']}"
end

execute 'run npm install' do
  action :nothing
  command 'npm install'
  cwd "#{node['uchiwa']['base_dir']}-#{node['uchiwa']['version']}"
end
