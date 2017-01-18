class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :users, through: :likes

  validates_presence_of :user_id

  validates :title,
             presence: true,
             length: {maximum: 140}

  validates :content,
             presence: true

  default_scope { order(created_at: :desc) }

  has_attached_file :content,
                    :storage => :cloudinary,
                    :path => ':id/:style/:filename',
                     styles: { big: "850x850>", medium: "600x600>", thumb: "100x100>" },
                     default_url: "/images/:style/missing.png"

  validates_attachment_content_type :content, content_type: /\Aimage\/.*\z/

  def upvote!(current_user)
    unless self.liked_by_user?(current_user)
      if self.disliked_by_user?(current_user)
        dislike = current_user.likes.where(post_id: self.id, positive: false)
        return false unless dislike.destroy_all
        like = current_user.likes.new(post_id: self.id, positive: true)
        self.upvotes += 1
        self.downvotes -= 1
        self.save
        return true if like.save
      else
        like = current_user.likes.new(post_id: self.id, positive: true)
        self.upvotes += 1
        self.save!
        return true if like.save
      end
    else
      like = current_user.likes.where(post_id: self.id, positive: true)
      return false unless like.destroy_all
      self.upvotes -= 1
      self.save
      return true
    end
  end

  def downvote!(current_user)
    unless self.disliked_by_user?(current_user)
      if self.liked_by_user?(current_user)
        like = current_user.likes.where(post_id: self.id, positive: true)
        return false unless like.destroy_all
        dislike = current_user.likes.new(post_id: self.id, positive: false)
        self.upvotes -= 1
        self.downvotes += 1
        self.save
        return true if dislike.save
      else
        dislike = current_user.likes.new(post_id: self.id, positive: false)
        self.downvotes += 1
        self.save
        return true if dislike.save
      end
    else
      dislike = current_user.likes.where(post_id: self.id, positive: false)
      return false unless dislike.destroy_all
      self.downvotes -= 1
      self.save
      return true
    end
  end

  def liked_by_user?(current_user)
    self.likes.where(user_id: current_user.id, positive: true).any?
  end

  def disliked_by_user?(current_user)
    self.likes.where(user_id: current_user.id, positive: false).any?
  end
end
