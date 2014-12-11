class UserRelation < ActiveRecord::Base
  belongs_to :user, :foreign_key => "user_id"
  belongs_to :user, :foreign_key => "friend_id"

  FOLLOW = 1 #
  FOLLOWED = 2 #
  FIREND = 3 #
  NORMAL = 0 #

  # 

end
