class Project < ActiveRecord::Base

  # Configs =========================

  include Sortable
  include Seoable

  acts_as_list

  # attr_accessor :picture_sent, :delete_picture

  CATEGORIES = [:personnal, :agency].freeze

  # Associations =====================

  has_many :pictures, -> { order :position }, as: :assetable, class_name: "Asset::ProjectPicture", dependent: :destroy
  has_many :project_tags, class_name: "ProjectTag", dependent: :destroy
  has_many :tags, through: :project_tags
  has_many :project_tasks, class_name: "ProjectTask", dependent: :destroy
  has_many :tasks, through: :project_tasks


  accepts_nested_attributes_for :pictures, allow_destroy: true

  # Validations =====================

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true


  # Callbacks =====================

  before_validation :sanitize_url



  # Scopes =====================

  scope :by_title, ->(val) {
      val.downcase!
      where(Project.arel_table[:title].matches("%#{val}%"))
    }
  scope :by_tag, ->(tag_id) {
    joins(:project_tags).where(project_tags: {tag_id: tag_id})
  }

  scope :visible, -> { where visible: true}
  scope :highlighted, -> { where highlighted: true}
  scope :homepage, -> {highlighted.visible}

  # Class Methods =====================

  def self.human_categories
    CATEGORIES.inject({}) {|hash, k| hash.merge I18n.t(k, scope: :categories) => k }
  end

  def self.apply_filters(params)
      klass = self

      if params[:by_title].present?
        klass = klass.by_title(params[:by_title])
      end

      if params[:by_tag].present?
        klass = klass.by_tag(params[:by_tag])
      end

    klass.apply_sorts(params)

  end

  # Instance Methods ================================

  def human_category
     I18n.t(self.category, scope: :categories)
  end

  def toggle_visible!
    toggle!(:visible)
  end

  def toggle_highlighted!
    toggle!(:highlighted)
  end

  # Tags ---------------------------------------------

  def new_tag
    @new_tag ||= self.project_tags.build()
  end

  def new_task
    @new_tasks ||= self.project_tasks.build()
  end

  def previous
    Project.find_by_position(self.position - 1)
  end

  def next
    Project.find_by_position(self.position + 1)
  end

  private #==========================================================

   # ajoute "http://" à l'url s'il n'y est pas déjà.
  def sanitize_url
    if self.web_link.present? && (self.web_link =~ %r{\Ahttps?://}).nil?
      self.web_link = "http://#{self.web_link}"
    end
  end

end