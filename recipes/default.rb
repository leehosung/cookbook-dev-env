#
# Cookbook Name:: dev-env
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'python'
include_recipe 'git::default'

directory "/home/#{node['dev-env']['user']}/.vim" do
  owner node['dev-env']['user']
  group node['dev-env']['group']
end

directory "/home/#{node['dev-env']['user']}/.vim/bundle" do
  owner node['dev-env']['user']
  group node['dev-env']['group']
end

git "/home/#{node['dev-env']['user']}/.vim/bundle/vundle" do
  repository 'https://github.com/gmarik/vundle.git'
  user node['dev-env']['user']
  group node['dev-env']['group']
  action :sync
end

template "/home/#{node['dev-env']['user']}/.vimrc" do
  source "vimrc.erb"
  owner node['dev-env']['user']
  group node['dev-env']['group']
  notifies :run, "bash[install-vundle]", :immediately
end

bash "install-vundle" do
  user node['dev-env']['user']
  action :nothing
  code <<-EOH
    vim +BundleInstall +qall
    EOH
end
