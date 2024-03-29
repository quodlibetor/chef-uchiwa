#
# Cookbook Name:: uchiwa
# Recipe:: default
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

user node['uchiwa']['user'] do
  system true
  home node['uchiwa']['base_dir']
  shell '/bin/false'
end

include_recipe 'uchiwa::install'

# Config
file "#{node['uchiwa']['base_dir']}/config.js.example" do
  action :delete
end

template "#{node['uchiwa']['base_dir']}/config.js" do
  user node['uchiwa']['user']
  group node['uchiwa']['group']
  mode 0640
end

# Logs
directory node['uchiwa']['log_dir'] do
  user node['uchiwa']['user']
  group node['uchiwa']['group']
end

# Init
include_recipe "uchiwa::supervisor"
