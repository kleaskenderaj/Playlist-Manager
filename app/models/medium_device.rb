class MediumDevice < ApplicationRecord
    belongs_to :medium
    belongs_to :device
  end