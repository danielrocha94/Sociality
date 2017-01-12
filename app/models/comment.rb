class Comment < ActiveRecord::Base
  MENTION_REGEX = /(?:\s|^)(?:@(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i

  belongs_to :user
  belongs_to :post

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

  def upvote!
    self.upvotes += 1
    self.save!
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
end
