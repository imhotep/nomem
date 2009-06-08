class Task < ActiveRecord::Base
  belongs_to :priority
  belongs_to :user
  validates_presence_of :title, :priority_id, :user_id
  validates_numericality_of :priority_id
  validates_inclusion_of :priority_id, :in => 1..4
end
