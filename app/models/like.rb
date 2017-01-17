class Like < ActiveRecord::Base
  validates_presence_of :user_id
  belongs_to :user
  belongs_to :comment
  belongs_to :post
end
