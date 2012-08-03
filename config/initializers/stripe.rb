if Rails.env.production?
  Stripe.api_key = "DvrFPNrPvyTbpOo512rq7VeRs30kOaTv"
  STRIPE_PUBLIC_KEY = "pk_05tlm1SXjxhZhA6eJj6TIqc86S0ZK"
else
  Stripe.api_key = "ATUkGYYV69Eeedy7mdNkcwoKq9rjTqTR"
  STRIPE_PUBLIC_KEY = "pk_05tlvIKXmg6OTHhnmBsLATaZPYmOA"
end
