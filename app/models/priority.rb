class Priority < ActiveRecord::Base
  has_many :tasks

  def to_s
    self.name
  end

end
