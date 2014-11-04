class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_default_seos!
  after_filter :flash_to_headers, if: ->{ request.xhr? && flash.present? }

  protected

  def set_seos_for object
    @seo_title       = object.seo_title if !object.seo_title.blank?
    @seo_description = object.seo_description if !object.seo_description.blank?
    @seo_keywords    = object.seo_keywords if !object.seo_keywords.blank?
  end

  private

  def set_default_seos!
    @seo_title       ||= "Claire Zuliani, portfolio"
    @seo_description ||= "Portfolio de Claire Zuliani, développeuse web full stack, ruby on rails et javascript"
    @seo_keywords    ||= "claire zuliani, web development, ruby on rails, meteor, portfolio"
  end

  # Pour les requêtes ajax
  def flash_to_headers
    [:error, :alert, :warning, :notice].each do |type|
      if flash[type].present?
        content = { message: flash[type], type: ApplicationHelper::FLASH_BS_TYPES[type] }
        response.headers['X-Message'] = content.to_json
        flash.discard
        break
      end
    end
  end
end