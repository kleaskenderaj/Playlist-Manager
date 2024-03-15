class Medium < ApplicationRecord
    has_many :playlist_items, dependent: :destroy
    has_many :playlists, through: :playlist_items
    has_many :medium_devices
    has_many :devices, through: :medium_devices
    scope :filter_by_title, ->(title) { where("LOWER(title) LIKE ?", "%#{title.downcase}%") if title.present? }
    # validates :title, presence: true, length: {minimum: 6, maximum: 100}
    # validates :description, presence: true, length: {minimum: 6, maximum: 100}
    # validate :valid_content_url

    private
  
    def valid_content_url
      if content_url.present?
        uri = URI.parse(content_url)
        unless uri.is_a?(URI::HTTP) && !uri.host.nil?
          errors.add(:content_url, 'is not a valid URL')
        end
      else
        errors.add(:content_url, 'can\'t be blank')
      end
    rescue URI::InvalidURIError
      errors.add(:content_url, 'is not a valid URL')
    end
end
