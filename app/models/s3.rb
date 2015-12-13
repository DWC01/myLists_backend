class S3

  def initialize(bucket, key, acl)
    @s3 = AWS::S3.new
    @uuid = SecureRandom.uuid
    @acl = {:acl=> acl}
    @bucket = bucket
    @key = key
  end

  # Param and Returns a hash
  # Key => File Name
  # Value => File
  def save_files(files)
    hash={}
    files.each do |name, file|
      hash[name] = save(file, name)
    end
    hash
  end

  def save(file, name)
    file = process(file)
    s3_obj = @s3.buckets[@bucket].objects["#{@key}/#{@uuid}-#{name}"].write(file, @acl)
    s3_obj.public_url.to_s
  end

  def save_temp(file)
    file = process(file)
    s3_obj = @s3.buckets[@bucket].objects[@key].write(file, @acl)
    s3_obj.public_url.to_s
  end

  def process(file)
    return file.to_blob if file.class.name == "Magick::Image"
    file
  end

  #--- Model Methods -----

  def self.public_url(bucket, key)
    s3 = AWS::S3.new
    s3.buckets[bucket].objects[key].public_url.to_s
  end

  def self.etag(bucket, key)
    s3 = AWS::S3.new
    s3.buckets[bucket].objects[key].etag
  end

  def self.download(bucket)
    s3 = AWS::S3.new
    s3.buckets[bucket]
  end

end