class Device < ApplicationRecord
    has_many :playlists
    has_many :medium_devices
    has_many :media, through: :medium_devices
    belongs_to :user
    validates :name, presence: true, length: {minimum: 6, maximum: 100}
    validates :unique_identifier, presence: true, length: {minimum: 10, maximum: 100}
end
