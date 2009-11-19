class Photo < ActiveRecord::Base
  has_attached_file :image ,
                    :styles => { :large => "800x600>", :medium => ["470x350>", :png], :thumb => "100x100>" },
                    :convert_options =>{ :medium => Proc.new { "-background black -polaroid #{rand(20) - 10}" } }
  belongs_to :album
  belongs_to :account
  acts_as_list :scope => :album

  validates_presence_of :account
end
