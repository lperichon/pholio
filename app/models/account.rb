class Account < ActiveRecord::Base
  belongs_to :manager, :class_name => "User"
  has_many :users
  has_many :pages
  has_many :albums
  has_many :photos

  validates_presence_of :name
end
