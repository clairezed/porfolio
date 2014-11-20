class Task < ActiveRecord::Base

  # Configs =========================

  include Sortable

  # acts_as_list


  # Associations =====================

  has_many :project_tasks, dependent: :restrict_with_exception
  has_many :projects, through: :project_tasks

  # Validations =====================

  validates :title, presence: true, uniqueness: true


  # Callbacks =====================

  # before_validation :sanitize_url


  # Scopes =====================

  scope :by_title, ->(val) {
    val.downcase!
    where(Task.arel_table[:title].matches("%#{val}%"))
  }

  scope :having_projects, -> { joins(:projects).uniq }

    scope :without_project, -> { where.not(id: ProjectTask.pluck(:task_id).uniq) }


  # Class Methods =====================

  # def self.sort_by_projects_count(order)
  #   self.joins(:project_tags).group("project_tags.tag_id").order("count(project_tags.tag_i‌​d) #{order}")
  # end

  def self.apply_filters(params)
      klass = self

      if params[:by_title].present?
        klass = klass.by_title(params[:by_title])
      end

      if params[:without_project].present?
        klass = klass.without_project
      end

    klass.apply_sorts(params)

  end

  # Instance Methods =====================


  private #==========================================================

   # ajoute "http://" à l'url s'il n'y est pas déjà.
  def sanitize_url
    if self.link.present? && (self.link =~ %r{\Ahttps?://}).nil?
      self.link = "http://#{self.link}"
    end
  end
end