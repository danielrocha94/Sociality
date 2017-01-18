class User < ActiveRecord::Base

  has_many :posts
  has_many :likes
  has_many :comments, through: :likes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save {self.first_name = first_name.downcase.capitalize}
  before_save {self.last_name = last_name.downcase.capitalize}
  validates :first_name, presence: true, length: {maximum: 30}
  validates :last_name, presence: true, length: {maximum: 30}

  has_attached_file :profile_picture,
                     styles: { profile: "200x200>", thumb: "50x50>", reply: "35x35>", tiny: "20x20" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\z/

  def admin?
    self.admin
  end
end
