class AddSkillsToAnalyses < ActiveRecord::Migration[7.1]
  def change
    add_column :analyses, :matching_skills, :text
    add_column :analyses, :missing_skills, :text
  end
end
