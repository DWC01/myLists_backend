class FileName
  
  def self.extension(file_name)
    file_name.split('.').pop
  end

  def self.dirty(file_name)
    file_name.split('/').pop
  end

  def self.clean(file_name)
    name = file_name.split('/').pop
    self.clean_name(file_name)
  end

  def self.clean_name(name)
    name = name.split('.')
    name.pop
    name.join
  end

end