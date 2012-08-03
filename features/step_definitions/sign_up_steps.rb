Given /^I am on the home page$/ do
  visit '/'
end

When /^I click a premium product link$/ do
  find('.premium').click
end

When /^I click on the call to action$/ do
  find('.call-to-action').click
end

When /^I sucessfully pay as "([^"]*)"$/ do |email|
 fill_in_order_details(email)
end

When /^I sleep for (\d+) seconds$/ do |count|
  sleep count.to_i
end

Then /^an order should exist for "([^"]*)"$/ do |email|
  Order.find_by_email(email).should be
end

Then /^I should be on the order success page$/ do
  page.should have_content("successful")
  current_path.should == order_path(Order.last)
end

Then /^stripe should have recorded a charge for the last order$/ do
  charge_id = Order.last.stripe_charge_id
  expect { Stripe::Charge.retrieve(charge_id) }.to_not raise_error
end

When /^I stub the download deliver/ do
  DownloadDeliverer.any_instance.stubs(:deliver)
end

Then /^the download deliverer should have been told to deliver an order$/ do
  DownloadDeliverer.any_instance.should have_received(:deliver)
end

def fill_in_order_details(email)
  fill_in 'Email', with: email
  fill_in 'order_github_username', with: 'foo'
  fill_in 'order_first_name', with: 'Joe'
  fill_in 'order_last_name', with: 'Blow'
  fill_in 'card_number', with: '4242424242424242'
  fill_in 'card_code', with: '123'
  select 'January', from: 'card_month'
  select '2025', from: 'card_year'

  sleep 1
  click_button 'Purchase'
end
