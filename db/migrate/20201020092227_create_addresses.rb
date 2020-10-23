class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|

      t.string  :postal_code,       null:false
      t.integer :prefecture_id,     null:false
      t.text    :city,              null:false
      t.text    :street_address,    null:false
      t.string  :phone_number,      null:false
      t.text    :building
      t.references :purchase,             foreign_key: true
      
      t.timestamps
    end
  end
end
