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

  def upvote!(current_user)
    unless self.liked_by_user?(current_user)
      if self.disliked_by_user?(current_user)
        dislike = current_user.likes.where(comment_id: self.id, positive: false)
        return false unless dislike.destroy_all
        like = current_user.likes.new(comment_id: self.id, positive: true)
        self.upvotes += 1
        self.downvotes -= 1
        self.save
        return true if like.save
      else
        like = current_user.likes.new(comment_id: self.id, positive: true)
        self.upvotes += 1
        self.save!
        return true if like.save
      end
    else
      like = current_user.likes.where(comment_id: self.id, positive: true)
      return false unless like.destroy_all
      self.upvotes -= 1
      self.save
      return true
    end
  end

  def downvote!(current_user)
    unless self.disliked_by_user?(current_user)
      if self.liked_by_user?(current_user)
        like = current_user.likes.where(comment_id: self.id, positive: true)
        return false unless like.destroy_all
        dislike = current_user.likes.new(comment_id: self.id, positive: false)
        self.upvotes -= 1
        self.downvotes += 1
        self.save
        return true if dislike.save
      else
        dislike = current_user.likes.new(comment_id: self.id, positive: false)
        self.downvotes += 1
        self.save
        return true if dislike.save
      end
    else
      dislike = current_user.likes.where(comment_id: self.id, positive: false)
      return false unless dislike.destroy_all
      self.downvotes -= 1
      self.save
      return true
    end
  end

  def replies
    Comment.where(reply_of: self.id)
  end

  def has_replies?
    Comment.where(reply_of: self.id).any?
  end

  def liked_by_user?(current_user)
    self.likes.where(user_id: current_user.id, positive: true).any?
  end

  def disliked_by_user?(current_user)
    self.likes.where(user_id: current_user.id, positive: false).any?
  end
end
