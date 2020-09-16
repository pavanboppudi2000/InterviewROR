class Interviewee < ApplicationRecord
    validates :email, format: { with: /.*@.*/ } , uniqueness: true ,presence: true
    validates :name ,presence: true
    validates :cgpa ,presence: true, numericality: {only_float: true} ,inclusion:0...10
    validates :clg ,presence: true

end
