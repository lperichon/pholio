class User < ActiveRecord::Base
  acts_as_authentic
  has_one :managed_account, :foreign_key => :manager_id, :class_name => 'Account'
  belongs_to :account
  validates_presence_of :account
  accepts_nested_attributes_for :account
end