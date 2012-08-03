# You can find your Fetch keys at the bottom of the screen at http://codeulate.fetchapp.com/admin/settings/payments
if Rails.env.production?
  FETCH_KEY = 'icodeforu'
  FETCH_TOKEN = 'fcei9kraeshe'
else
  FETCH_KEY = 'xxx'
  FETCH_TOKEN = 'yyy'
end

# This should be a string representation of the SKU from FetchApp's control panel. ('1' by default)
FETCH_SKU = '001'
