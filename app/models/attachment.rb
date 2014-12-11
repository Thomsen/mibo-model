class Attachment < ActiveRecord::Base

  has_attached_file :attach, :styles => { :medium => "480x240", :thumb => "200x180" }
  validates_attachment_content_type :attach, :content_type => /\Aimage\/.*\Z/
  
end
