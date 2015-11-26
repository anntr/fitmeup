class Menu < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  belongs_to :user

  scope :saved_menus, lambda { |curr_user|
                          where(:user => curr_user, :saved => true)}


  def saved?
    saved
  end
end
