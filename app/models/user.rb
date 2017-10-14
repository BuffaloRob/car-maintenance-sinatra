class User < ActiveRecord::Base
  has_secure_password
  has_many :cars
  has_many :maintenance_items, :through => :cars

  def slug
    name.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end