require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe service('nrpe') do
    it { should be_enabled }
    it { should be_running }
end

cmd = '/opt/nagios/libexec/check_nrpe -H 127.0.0.1 -c check_users'
describe command(cmd) do
    expected_stdout = 'USERS OK - 1 users currently logged in |users=1;5;10;0'
    it { should return_stdout expected_stdout }
end
