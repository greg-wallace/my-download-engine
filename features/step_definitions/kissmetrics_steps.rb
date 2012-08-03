Then /^the page contains the KISSmetrics tracking code$/ do
  page.body.should include("_kmq")
end

Then /^KISSmetrics should receive an identify event for "([^"]*)"$/ do |email|
  page.body.should include "_kmq.push(['identify', '#{email}'])"
end

Then /^KISSmetrics should receive a purchased event$/ do
  page.body.should include "_kmq.push(['record', 'Purchased'])"
end

Then /^KISSmetrics should receive a billed event for 149 dollars$/ do
  page.body.should include "_kmq.push(['billed', 149.00])"
end

Then /^KISSmetrics should receive a viewed checkout event$/ do
  page.body.should include "_kmq.push(['record', 'Viewed Checkout'])"
end

Then /^KISSmetrics receives a viewed landing page event$/ do
  page.body.should include "_kmq.push(['record', 'Viewed Landing Page'])"
end
