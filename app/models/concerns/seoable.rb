module Seoable
  extend ActiveSupport::Concern

  included do

    before_validation :init_slug, on: :create
    before_validation :parameterize_slug
    before_save :set_seo_title

    def to_param
      "#{self.slug}-#{self.id}"
    end

    def self.from_param( param )
      find( param.to_s[/\d+\Z/] )
    end

  end

  private

  # Si non défini à la création, le slug correspond aux 100 premiers caractères du title.
  def init_slug
    self.slug = self.title.to_s.truncate(100) if self.slug.blank?
  end

  # Le slug ne dépasse pas 100 caractères.
  def parameterize_slug
    self.slug = self.slug.to_s.truncate(100).parameterize
  end

  # Si non défini, le champ SEO title prend les 156 premiers caractères du title.
  def set_seo_title
    self.seo_title = self.title if self.seo_title.blank?
    self.seo_title = self.seo_title.truncate(156)
  end

end