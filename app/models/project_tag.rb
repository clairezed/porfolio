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


  # Scopes =====================

  scope :persisted, -> {where.not(id: nil) }


  # Instance Methods =====================


  private #==========================================================

end