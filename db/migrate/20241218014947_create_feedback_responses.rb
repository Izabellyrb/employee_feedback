# frozen_string_literal: true

class CreateFeedbackResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :feedback_responses do |t|
      t.string :name
      t.string :email
      t.string :corporate_email
      t.string :location
      t.string :company_tenure
      t.string :gender
      t.string :generation
      t.string :company_level_0
      t.string :directorate_level_1
      t.string :management_level_2
      t.string :coordination_level_3
      t.string :area_level_4
      t.date :response_date
      t.integer :interest_in_position
      t.text :comments_interest_in_position
      t.integer :contribution
      t.text :comments_contribution
      t.integer :learning_and_development
      t.text :comments_learning_and_development
      t.integer :feedback
      t.text :comments_feedback
      t.integer :interaction_with_manager
      t.text :comments_interaction_with_manager
      t.integer :clarity_about_career_opportunities
      t.text :comments_clarity_about_career_opportunities
      t.integer :expectation_of_permanence
      t.text :comments_expectation_of_permanence
      t.integer :employee_net_promoter_score
      t.text :open_comments_enps
      t.references :department, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.references :function, null: false, foreign_key: true

      t.timestamps
    end
  end
end
