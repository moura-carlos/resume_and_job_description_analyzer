class Analyzer < ApplicationRecord
    has_one :resume, dependent: :destroy
    has_one :job_description, dependent: :destroy
    has_one :analysis, dependent: :destroy
    
    accepts_nested_attributes_for :resume
    accepts_nested_attributes_for :job_description
end
