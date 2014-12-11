class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :content

  validates :text, presence: true
  
end
