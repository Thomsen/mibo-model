class User < ActiveRecord::Base

  has_many :contents

  attr_accessor :form_password # no need db
#  attr_accessible :username, :email, :password # need db, rails 4+ move controller

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  
  validates :username, presence: true,
            length:           {minimum: 4},
            uniqueness:       {case_sensitive: false}

  validates :form_password, presence: true,
            length:           {minimum: 6, maximum: 16}

  validates :email, :presence => true,
           :format            => {:with => email_regex },
           :uniqueness        => {:message => " already exit",
                                  :case_sensitive => false }

  has_attached_file :portrait_uri, :styles => { :medium => "300x300", :thumb => "100x100" }, :default_url => "//placehold.it/80"
  validates_attachment_content_type :portrait_uri, :content_type => /\Aimage\/.*\Z/

  before_save :encrypt_password

  def has_password?(submitted_password)
    puts "sub pass: #{submitted_password}"
    puts "pass: #{self.password}"
    puts "spas: #{encrypt(submitted_password)}"
    self.password == encrypt(submitted_password)
  end

  def self.authen_by_username(username, submitted_password)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authen_by_email(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  private
  def encrypt_password
    puts "reg pass: #{form_password}"
    self.passsalt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{form_password}") if self.new_record?
    self.password = encrypt(form_password)
  end
  
  def encrypt(pass)
    Digest::SHA2.hexdigest("#{self.passsalt}--#{pass}")
  end
  
end
