module Raport
  class FileUploader < CarrierWave::Uploader::Base

    include CarrierWave::MiniMagick

    storage Raport.config.storage

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    process :set_content_type

    def set_content_type
      new_content_type = 'binary/octet-stream'

      if file.respond_to?(:content_type=)
        file.content_type = new_content_type
      else
        file.instance_variable_set(:@content_type, new_content_type)
      end
    end
    
    # process :set_file_size
    #
    # def set_file_size
    #   model.file_size = file.size
    # end

    def filename
      model.respond_to?(:filename) ? model.filename : super
    end

  end
end