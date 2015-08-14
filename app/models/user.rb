class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :omniauthable#, :validatable

  validates :default_email, presence: true, email: true#, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true

  has_many :identities
  has_and_belongs_to_many :episodes

  has_many :emails, dependent: :destroy
  after_commit :save_default_email, on: :create

  belongs_to :default_email, class_name: "Email"
  default_scope { includes :default_email }

  accepts_nested_attributes_for :emails, reject_if: :all_blank, allow_destroy: true

  def email
    default_email.email rescue nil
  end

  def email= email
    self.default_email = emails.where(email: email).first_or_initialize
  end

  def email_changed?
    self.default_email && self.default_email.email_changed?
  end

  def email_was
    self.default_email.email_was
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.

    user = signed_in_resource ? signed_in_resource : identity.user 
  end

  def self.having_email email
    emails = Email.where(email: email) 
    emails.any? ? emails.first.user : nil
  end

  def self.find_first_by_auth_conditions warden_conditions
    conditions = warden_conditions.dup
    if email = conditions.delete(:email)
      having_email email
    else
      super(warden_conditions)
    end
  end

  private

  def save_default_email
    if default_email.user.blank?
      default_email.user = self
    elsif default_email.user != self
      raise Exceptions::EmailConflict
    end

    default_email.save!
  end  

end
