class Asset < ActiveRecord::Base
  # Configs ======================================================================

  Paperclip.interpolates :assetable_id do |attachment, style|
    attachment.instance.assetable_id
  end

  # Associations =================================================================

  belongs_to :assetable, polymorphic: true
  
  # Validations ==================================================================

  validates :type, presence: true
end