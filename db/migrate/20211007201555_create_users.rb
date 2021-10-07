class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    # this is called a block
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
