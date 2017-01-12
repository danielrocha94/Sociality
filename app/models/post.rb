class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates_presence_of :user_id

  validates :title,
             presence: true,
             length: {maximum: 140}

  validates :content,
             presence: true

  default_scope { order(created_at: :desc) }

  has_attached_file :content, styles: { big: "850x850>", medium: "600x600>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :content, content_type: /\Aimage\/.*\z/

  def upvote!
    self.upvotes += 1
    self.save
  end

  def downvote!
    self.downvotes += 1
    self.save
  end
end
