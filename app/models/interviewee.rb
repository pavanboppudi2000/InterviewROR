class Interviewee < ApplicationRecord
    validates :email, format: { with: /.*@.*/ } , uniqueness: true ,presence: true
    validates :name ,presence: true
    validates :cgpa ,presence: true, numericality: {only_float: true} ,inclusion:0...10
    validates :clg ,presence: true
    validates :resume,presence: true
    has_attached_file :resume
    validates_attachment_content_type :resume, :content_type => ['application/pdf']

end
