class Post < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id

  validates :title,
             presence: true,
             length: {maximum: 140}

  validates :content,
             presence: true

  default_scope { order(created_at: :desc) }

  def upvote!
    self.upvotes += 1
    self.save
  end

  def downvote!
    self.downvotes += 1
    self.save
  end
end
