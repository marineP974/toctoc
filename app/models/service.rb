class Service < ApplicationRecord
  include PgSearch::Model
  belongs_to :user


  NAMES = ["House cleaning", "Drill", "Piano lessons", "Plant care", "Cat feeding", "Grocery Shopping", "Receive packages"]
  TYPOLOGIES = ["Loan", "Service"]

  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
