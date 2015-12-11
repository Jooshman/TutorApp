class Userlogin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  searchkick word_start: [:email, :skills, :classes]
  def search_data 
    {
    email: email,
    skills: skills,
    classes: classes
  }
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :send_admin_mail
  

  ratyrate_rateable 'overall', 'clarity', 'knowledge', 'politeness', 'flexibility'
  ratyrate_rater

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#"}, :default_url => "/images/:style/missing.png"
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
