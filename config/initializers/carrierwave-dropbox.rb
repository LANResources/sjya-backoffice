# encoding: utf-8
require 'dropbox_sdk'

module CarrierWave
  module Storage
    class Dropbox < Abstract
      class File
        def download
          @client.get_file api_path
        end

        def metadata
          @metadata ||= @client.metadata api_path
        end

        def content_type
          metadata['mime_type'].to_s
        end

        def size
          metadata['size'].to_s
        end

        private

        def api_path
          path = @path
          path = "/Public/#{path}" if @config[:access_type] == "dropbox"
          path
        end
      end
    end
  end
end
