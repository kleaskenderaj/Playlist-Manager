class Playlist < ApplicationRecord
    belongs_to :device
    has_many :playlist_items, dependent: :destroy
    belongs_to :user
    has_many :medium, through: :playlist_items
    validates :title, presence: true, length: {minimum: 6, maximum: 100}
    validates :description, presence: true, length: {minimum: 6, maximum: 100}
    scope :filter_by_title, ->(title) { where("title LIKE ?", "%#{title}%") if title.present? }

end