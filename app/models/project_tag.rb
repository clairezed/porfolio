class ProjectTag < ActiveRecord::Base

  # Configs =========================
  acts_as_list scope: [:project]

  # Associations =====================

  belongs_to :tag
  belongs_to :project

  # Validations =====================

  validates :project_id, presence: true
  validates :tag_id, presence: true, uniqueness: {
                  scope:    :project_id,
                  case_sensitive: false,
                  message:  "existe déjà"
              }


  # Callbacks =====================

    after_destroy :try_tag_destruction

  # Scopes =====================

  scope :persisted, -> {where.not(id: nil) }

  # Class Methods =============================

  def self.initialize_from_project(params)
    tag = Tag.where(title: params[:title]).first_or_create
    self.new(
      project_id: params[:project_id],
      tag_id: tag.id)
  end

  # Instance Methods =====================


  private #==========================================================

  # Tentative systématique de destruction de la task
  # rescue nil pour ne pas bloquer le processus qd destruction impossible
  def try_tag_destruction
    self.tag.destroy rescue nil
  end

end