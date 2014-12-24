class ProjectTask < ActiveRecord::Base

  # Configs =========================

  acts_as_list scope: [:project]

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

  after_destroy :try_task_destruction

  # Scopes =====================

  scope :persisted, -> {where.not(id: nil) }


 # Class Methods =============================

  def self.initialize_from_project(params)
    task = Task.where(title: params[:title]).first_or_create
    self.new(
      project_id: params[:project_id],
      task_id: task.id)
  end


  # Instance Methods =====================

  # Tentative systématique de destruction de la task
  # rescue nil pour ne pas bloquer le processus qd destruction impossible
  def try_task_destruction
    self.task.destroy rescue nil
  end

  private #==========================================================

end