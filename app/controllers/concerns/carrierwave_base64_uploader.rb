module CarrierwaveBase64Uploader
  extend ActiveSupport::Concern

  private

  def base64_conversion(uri_str, filename = 'base64')
    img_data = split_base64(uri_str)
    img_data_binary = Base64.decode64(img_data[:data])

    temp_img_file = Tempfile.new(filename)
    temp_img_file.binmode
    temp_img_file << img_data_binary
    temp_img_file.rewind

    img_params = {:filename => "#{filename}.#{img_data[:extension]}", :type => img_data[:type], :tempfile => temp_img_file}
    ActionDispatch::Http::UploadedFile.new(img_params)
  end

  def split_base64(uri_str)
    if uri_str.match(%r{data:(.*?);(.*?),(.*)$})
      uri = Hash.new
      uri[:type] = $1
      uri[:encoder] = $2
      uri[:data] = $3
      uri[:extension] = $1.split('/')[1]
      return uri
    else
      return nil
    end
  end
end