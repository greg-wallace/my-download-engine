class Order < ActiveRecord::Base
  PRODUCT_PRICE_IN_CENTS = 14900

  attr_accessor :stripe_card_token

  validates :email, presence: true
  validates :github_username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def save_with_payment
    if valid?
      charge = Stripe::Charge.create(description: email, card: stripe_card_token, amount: PRODUCT_PRICE_IN_CENTS, currency: 'usd')
      self.stripe_charge_id = charge.id
      save!
    end
  rescue Stripe::InvalidRequestError => error
    logger.error "Stripe error while creating customer: #{error.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end
