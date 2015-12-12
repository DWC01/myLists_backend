class Avatar < ActiveRecord::Base
  after_create :construct_and_save_avatar
  before_update :construct_avatar
  belongs_to :user


  # --- After Create -----------------

  def construct_and_save_avatar
    process_file_upload_data
    proccess_images
    save_files_to_s3
    set_attributes
    self.save
  end

  # --- Before Update -----------------

  def construct_avatar
    process_file_upload_data
    proccess_images
    save_files_to_s3
    set_attributes
  end

  # --- Process File Data -------------------

  def process_file_upload_data
    @meta_data = JSON.parse(self.meta_data).symbolize_keys if self.meta_data
    set_temp_file_path
  end

  def set_temp_file_path
    if @meta_data
      @meta_data_path = S3.public_url(@meta_data[:bucket], @meta_data[:key])
    else
      @meta_data_path = default_img_url
    end
  end

  # --- Process Ceative -------------------

  def proccess_images
    @images = ImageProcessor.new(@meta_data_path).resize_to_fill({
      profile_img: {
        width: 75,
        height: 75
      },
      nav_img: {
        width: 30, 
        height: 30
      }
    })
  end

  # --- Save Ceative to S3 -------------------

  def save_files_to_s3
    s3 = S3.new(S3Config.bucket, S3Config.key(self), :public_read)
    @urls = s3.save_files(@images)
  end

  # --- Setting Attributes -------------------

  def set_attributes
    self.name = file_name(@meta_data)
    self.nav_url = @urls[:nav_img]
    self.profile_url = @urls[:profile_img]
    self.original_url = @urls[:original_img]
  end

  #---------------------------#
  #     Helper Methods        #
  #---------------------------#

  def file_name(file)
    file ? FileName.clean(file[:name]) : default_name
  end

  def default_name
    'Abraham Lincoln'
  end

  def default_img_url
    'https://s3-us-west-1.amazonaws.com/t-displayadtech/assets/fallbacks/abe.jpg'
  end

end
