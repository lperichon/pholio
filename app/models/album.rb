class Album < ActiveRecord::Base
  belongs_to :account
  belongs_to :album
  has_many :photos, :dependent => :destroy, :order => "position"
  acts_as_list
  validates_presence_of :name
  validates_presence_of :account
end
