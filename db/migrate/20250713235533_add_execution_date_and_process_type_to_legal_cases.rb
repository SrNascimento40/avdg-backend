class AddExecutionDateAndProcessTypeToLegalCases < ActiveRecord::Migration[8.0]
  def change
    add_column :legal_cases, :execution_date, :datetime
    add_column :legal_cases, :process_type, :string
  end
end
