class Person < ActiveRecord::Base
  has_and_belongs_to_many :authored_packages,   class_name: "Package", join_table: "packages_authors"
  has_and_belongs_to_many :maintained_packages, class_name: "Package", join_table: "packages_maintainers"

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    s = name
    s << " <#{email}>" if email.present?
    s
  end
end
