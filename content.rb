class Content < ActiveRecord::Base
  
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :attachpacket, :foreign_key => "packet_id"
  
end
