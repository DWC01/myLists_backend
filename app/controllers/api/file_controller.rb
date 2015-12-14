module Api
  class FileController < Api::BaseController

  def initialize
    @s3 = AWS::S3.new
    @env = Rails.env
    @uuid = SecureRandom.uuid
  end

  def upload
    @name = params[:file].original_filename
    @file = open(params[:file])

    save_to_s3

    render json: {bucket: bucket, key: key, name: @name}
  end

  def save_to_s3
    s3_obj = @s3.buckets[bucket].objects[key].write(@file, {:acl=>:public_read})
  end

  def bucket
   "t-displayadtech"
  end

  def key
    "uploads/#{Rails.env}/temp/#{@uuid}/#{@name}"
  end

 end
end