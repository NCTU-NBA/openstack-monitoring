# Cookbook Name:: openstack-monitoring
# Recipe:: rabbitmq-openstack
#
# Copyright 2013, Rackspace US, Inc.
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
include_recipe "monitoring"

# monitoring setup..
if node.recipe?("rabbitmq-openstack::server")
  platform_options = node["rabbitmq"]["platform"]
  monitoring_procmon "rabbitmq-server" do
    action :remove
  end

  monitoring_metric "rabbitmq-server-proc" do
    type "proc"
    proc_name "rabbitmq-server"
    proc_regex platform_options["rabbitmq_service_regex"]
    alarms(:failure_min => 1.0)
  end
end
