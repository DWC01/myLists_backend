class S3Config
  
  def self.bucket
    "my-lists"
  end

  def self.key(model)
    "uploads/#{Rails.env}/#{model.class.name.downcase}/#{model.id}"
  end

  def self.temp_key(name)
    "uploads/#{Rails.env}/temp/#{SecureRandom.uuid}/#{name}"
  end

end