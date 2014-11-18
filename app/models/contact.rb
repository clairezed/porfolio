class Contact < ActiveRecord::Base
  include Sortable

  # Configurations =============================================================

  # Associations ===============================================================

  # Callbacks ==================================================================

  validates :email, presence: true
  validates :subject, presence: true
  validates :message, presence: true

  # after_create :notify_admin

  # Scopes =====================================================================

  scope :unread, -> { where read: false }
  scope :by_email, ->(val) {
    val.downcase!
    where(Contact.arel_table[:email].matches("%#{val}%"))
  }

  # Class Methods ==============================================================
  def self.apply_filters(params)
    klass = self

    if params[:by_name_or_email].present?
      klass = klass.by_name_or_email(params[:by_name_or_email])
    end

    klass.apply_sorts(params)
  end

  # Instance Methods ===========================================================

  private #=====================================================================

  def notify_admin
    AdminMailer.contact_created(self).deliver
  end

end