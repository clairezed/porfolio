class Tag < ActiveRecord::Base

  # Configs =========================

  include Sortable
  # include Seoable

  # acts_as_list


  # Associations =====================

  has_many :project_tags, dependent: :destroy
  has_many :projects, through: :project_tags

  # Validations =====================

  validates :title, presence: true, uniqueness: true


  # Callbacks =====================

  # before_validation :sanitize_url


  # Scopes =====================

  scope :by_title, ->(val) {
      val.downcase!
      where(Tag.arel_table[:title].matches("%#{val}%"))
    }

  scope :having_projects, -> { joins(:projects).uniq }

  # scope :by_projects_count, -> {

  # }

  # Class Methods =====================

  # def self.apply_filters(params)
  #     klass = self

  #     if params[:by_title].present?
  #       klass = klass.by_title(params[:by_title])
  #     end

  #   klass.apply_sorts(params)

  # end

  # Instance Methods =====================


  private #==========================================================

   # ajoute "http://" à l'url s'il n'y est pas déjà.
  def sanitize_url
    if self.link.present? && (self.link =~ %r{\Ahttps?://}).nil?
      self.link = "http://#{self.link}"
    end
  end
end