class ImageProcessor
  attr_reader :original_img

  def initialize(file_path)
    @hash={}
    @original_img = Magick::Image::read(file_path).first
    @hash[:original_img] = @original_img
  end

  def resize_to_fill(images)
    images.each do |name, sizes|
      @hash[name] = @original_img.clone.resize_to_fill(sizes[:width],sizes[:height])
    end
    @hash
  end
  
end