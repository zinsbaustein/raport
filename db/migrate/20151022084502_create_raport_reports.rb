class CreateRaportReports < ActiveRecord::Migration[4.2]
  def change
    create_table :raport_reports do |t|
      t.string :name
      t.string :state
      t.string :resource_class_name
      t.string :file
      t.string :locale
      t.text :query, limit: 16777215
      t.string :template
      t.string :action_name
      t.references :user, polymorphic: true, index: true
      t.datetime :invalid_at

      t.timestamps null: true
    end
  end
end
