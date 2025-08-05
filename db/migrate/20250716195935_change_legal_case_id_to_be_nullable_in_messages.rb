class ChangeLegalCaseIdToBeNullableInMessages < ActiveRecord::Migration[8.0]
  def change
    change_column_null :messages, :legal_case_id, true
  end
end
