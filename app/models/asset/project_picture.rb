class Asset::ProjectPicture < Asset

  acts_as_list scope: :assetable_id

  has_attached_file :asset,
    styles: {
      thumb: "30x30#",
      thumb_detail: "100x100>",
      list: "400x300#",
      large: "800"
    },
    storage: :s3,
    s3_credentials: {
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_secret_access_key,
      bucket: Rails.application.secrets.s3_bucket_name
    },
    path: ":rails_root/projects/:assetable_id/pictures/:id/:style.:extension"

  validates_attachment :asset, presence: true,
    content_type: {content_type: ['image/gif', 'image/jpeg', 'image/png']}

end