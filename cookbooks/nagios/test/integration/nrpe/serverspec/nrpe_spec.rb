require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe service('nrpe') do
    it { should be_enabled }
    it { should be_running }
end
