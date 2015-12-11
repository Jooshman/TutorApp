class Userlogin < ActiveRecord::Base
  include Elasticsearch::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable 
  searchkick word_start: [:email, :skills, :classes, :price, :gender, :first, :last]

  def search_data 
    {
    email: email,
    skills: skills,
    classes: classes,
    first: first,
    last: last,
    price: price,
    gender: gender,
    ratings: ratings,
    age: age
  }
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_admin_mail
  

  ratyrate_rateable 'overall', 'clarity', 'knowledge', 'politeness', 'flexibility'
  ratyrate_rater

  if Rails.env.development?
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#"}, :default_url => "/images/:style/missing.png"
  else
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#"}, :default_url => "/images/:style/missing.png",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                      :path => ":style/:id_:filename"
  end
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  acts_as_messageable

  has_many :userreviews

  has_many :favorites
  has_many :favorite_userlogins, through: :favorites, source: :favorited, source_type: 'Userlogin'

  def mailboxer_name
    self.first
  end

  def mailboxer_email(object)
    self.email
  end


  def send_admin_mail
    UserMailer.welcome_email(self).deliver
  end

  def calculate_age(birthday)
    if (birthday.blank?) then 
      birthday = Time.now.utc.to_date
      now = Time.now.utc.to_date
      now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
    else
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
    end
  end

  def average_rate
    ratings = Rate.where(rateable_id: self.id)
    total = 0
    count = 0
    ratings.each do |rate|
      total = total + rate.stars
      count = count + 1
    end

    if count != 0
      return total/count
    else
      return 0
    end
  end

  def parse_database_tags(list)
    if(list.blank? || list == "[""]") then
      return [""]
    else
      newlist = list.dup
      newlist = newlist.gsub! '"',''
      newlist.gsub! '[',''
      newlist.gsub! ']',''
      newlist = newlist.split(", ")
      return newlist
    end
  end
end
