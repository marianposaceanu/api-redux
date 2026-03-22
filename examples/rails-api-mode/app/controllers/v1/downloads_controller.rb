module V1
  class DownloadsController < ApplicationController
    CONTENT = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".freeze

    def show
      response.set_header("Accept-Ranges", "bytes")
      response.set_header("ETag", '"download-v1"')

      range_header = request.headers["Range"].to_s
      return render_full unless range_header.present?

      match = range_header.match(/bytes=(\d+)-(\d+)?/)
      return render_invalid_range unless match

      start_byte = match[1].to_i
      end_byte = match[2] ? match[2].to_i : CONTENT.bytesize - 1

      return render_invalid_range if start_byte >= CONTENT.bytesize || end_byte < start_byte

      end_byte = [end_byte, CONTENT.bytesize - 1].min
      chunk = CONTENT.byteslice(start_byte..end_byte)

      response.set_header("Content-Range", "bytes #{start_byte}-#{end_byte}/#{CONTENT.bytesize}")
      response.set_header("Content-Length", chunk.bytesize.to_s)

      render plain: chunk, status: :partial_content, content_type: "application/octet-stream"
    end

    private

    def render_full
      response.set_header("Content-Length", CONTENT.bytesize.to_s)
      render plain: CONTENT, content_type: "application/octet-stream"
    end

    def render_invalid_range
      response.set_header("Content-Range", "bytes */#{CONTENT.bytesize}")
      head :range_not_satisfiable
    end
  end
end
