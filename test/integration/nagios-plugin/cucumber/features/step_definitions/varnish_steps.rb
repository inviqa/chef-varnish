
Given /^the Nagios plugin is installed$/ do

end

When /^I request the plugin help$/ do
  @help = `/usr/lib64/nagios/plugins/libexec/check_varnish -h 2>&1`
end

Then /^I see that the help is shown$/ do
  expect(@help).to match(/usage: check_varnish/)
end
