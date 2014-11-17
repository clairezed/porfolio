class ProjectTask < ActiveRecord::Base

  # Configs =========================

  # Associations =====================

  belongs_to :task
  belongs_to :project

  # Validations =====================

  validates :project_id, presence: true
  validates :task_id, presence: true, uniqueness: {
                  scope:    :project_id,
                  case_sensitive: false,
                  message:  "existe déjà"
              }


  # Callbacks =====================


  # Scopes =====================

  scope :persisted, -> {where.not(id: nil) }


  # Class Methods =====================


  # Instance Methods =====================


  private #==========================================================

end