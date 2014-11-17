class Asset::ProjectPicture < Asset

  acts_as_list scope: :assetable_id

  has_attached_file :asset,
    styles: {
      thumb: "30x30#",
      thumb_detail: "100x100>",
      list: "400x275#",
      detail: "250",
      large: "800#"
    },
    url: "/uploads/projects/:assetable_id/pictures/:id/:style.:extension",
    path: ":rails_root/public/uploads/projects/:assetable_id/pictures/:id/:style.:extension"

  validates_attachment :asset, presence: true,
    content_type: {content_type: ['image/gif', 'image/jpeg', 'image/png']}

end