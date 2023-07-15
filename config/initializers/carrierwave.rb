require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'

    config.storage = :file
    config.enable_processing = Rails.env.development?
end
