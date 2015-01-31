
Given /^Varnish is installed$/ do

end

Given /^Varnish is started$/ do
  `sudo service varnish start`
end

When /^I run varnishlog$/ do
  `varnishlog -k 2 -w /tmp/varnish.log`
  `sleep 5 && killall -KILL varnishlog`
end

Then /^I should see ping$/ do
  expect(File.read('/tmp/varnish.log')).to match(/Rd ping/m)
end

When /^the service status is requested$/ do
  @status = `sudo service varnish status`
end

Then /^it should be running$/ do
  expect(@status).to match(/running/)
end