class Word < ApplicationRecord
  has_many :details, dependent: :destroy
end
