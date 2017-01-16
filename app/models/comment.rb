class Comment < ActiveRecord::Base
  MENTION_REGEX = /(?:\s|^)(?:@(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i

  belongs_to :user
  belongs_to :post

  has_many :likes
  has_many :users, through: :likes

  validates_presence_of :content, :user_id, :post_id

  def self.initialize_reply(content, comment_id, user_id)
    comment = Comment.find(comment_id)
    reply = new ({
      user_id: user_id,
      post_id: comment.post.id,
      content: content,
      is_reply: true,
      reply_of: comment.reply_of || comment_id
    })
  end

  def upvote!(liked_by)
    like = Like.new(user_id: liked_by.id, comment_id: self.id )
    self.upvotes += 1
    self.save!
    return like
  end

  def downvote!
    self.downvotes += 1
    self.save
  end

  def replies
    Comment.where(reply_of: self.id)
  end

  def has_replies?
    Comment.where(reply_of: self.id).any?
  end

  def has_been_liked?
    self.likes.where(user_id: user.id).any?
  end
end
