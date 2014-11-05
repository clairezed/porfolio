class Asset < ActiveRecord::Base
  belongs_to :assetable, polymorphic: true

  Paperclip.interpolates :assetable_id do |attachment, style|
    attachment.instance.assetable_id
  end
end