class Project < ActiveRecord::Base

  # Configs =========================

  include Sortable
  include Seoable

  attr_accessor :picture_sent, :delete_picture

  CATEGORIES = [:personnal, :agency].freeze

  # Associations =====================

  has_many :pictures, -> { order :position }, as: :assetable, class_name: "Asset::ProjectPicture", dependent: :destroy

  accepts_nested_attributes_for :pictures, allow_destroy: true

  # Validations =====================

  validates :title, presence: true
  validates :description, presence: true
  # validates :category, presence: true


  # Callbacks =====================

  before_validation :sanitize_url


  # Scopes =====================

  scope :by_title, ->(val) {
      val.downcase!
      where(Project.arel_table[:title].matches("%#{val}%"))
    }

  # Class Methods =====================

  def self.human_categories
    CATEGORIES.inject({}) {|hash, k| hash.merge I18n.t(k, scope: :categories) => k }
  end

  def self.apply_filters(params)
      klass = self

      if params[:by_title].present?
        klass = klass.by_title(params[:by_title])
      end

      # if params[:by_category].present?
      #   klass = klass.by_category_id(params[:by_category_id])
      # end

    klass.apply_sorts(params)

  end

  # Instance Methods =====================

  def human_category
     I18n.t(self.category, scope: :categories)
  end

  # def save_with_assets
  #   if self.document_sent
  #     doc = Asset::PostDocument.new(asset: self.document_sent)
  #     self.errors.add(:document_sent, "n'a pas un format reconnu") if !doc.valid?(:asset)
  #   end

  #   if self.errors.empty? && self.valid?
  #     self.save
  #     self.document = doc if doc && doc.valid?(:asset)
  #     true
  #   else
  #     false
  #   end
  # end



  private #==========================================================

   # ajoute "http://" à l'url s'il n'y est pas déjà.
  def sanitize_url
    if self.link.present? && (self.link =~ %r{\Ahttps?://}).nil?
      self.link = "http://#{self.link}"
    end
  end

end