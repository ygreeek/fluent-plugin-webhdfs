module Fluent::Plugin
  class WebHDFSOutput < Output
    class ZstdCompressor < Compressor
      WebHDFSOutput.register_compressor('zstd', self)

      def initialize(options = {})
        begin
          require "zstandard"
        rescue LoadError
          raise Fluent::ConfigError, "Install zstandard gem before use of zstd compressor"
        end
      end

      def ext
        ".zst"
      end

      def compress(chunk, tmp)
        tmp.binmode
        tmp.write Zstandard.deflate(chunk.read)
      end
    end
  end
end
