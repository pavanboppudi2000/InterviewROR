class Interviewer < ApplicationRecord
    validates :email, format: { with: /.*@.*/ } , uniqueness: true ,presence: true
    validates :name ,presence: true
end
