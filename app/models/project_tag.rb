class ProjectTag < ActiveRecord::Base

  # Configs =========================

  # Associations =====================

  belongs_to :tag
  belongs_to :project

  # accepts_nested_attributes_for :pictures, allow_destroy: true

  # Validations =====================

  validates :project_id, presence: true
  validates :tag_id, presence: true, uniqueness: {
                  scope:    :project_id,
                  case_sensitive: false,
                  message:  "existe déjà"
              }


  # Callbacks =====================

  # before_validation :sanitize_url


  # Scopes =====================

  scope :persisted, -> {where.not(id: nil) }
  # scope :by_title, ->(val) {
  #     val.downcase!
  #     where(Tag.arel_table[:title].matches("%#{val}%"))
  #   }

   # scope :having_projects, -> { joins(:projects).uniq }

  # Class Methods =====================

  # def self.human_categories
  #   CATEGORIES.inject({}) {|hash, k| hash.merge I18n.t(k, scope: :categories) => k }
  # end

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
  # def sanitize_url
  #   if self.link.present? && (self.link =~ %r{\Ahttps?://}).nil?
  #     self.link = "http://#{self.link}"
  #   end
  # end
end