class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  validates :title, uniqueness: true
  validates :title, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.49 , message: "Price can not be less then 0.49$" }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image'
  }
end


