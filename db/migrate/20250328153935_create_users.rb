class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, comment: "사용자 정보 테이블" do |t|
      t.string :name

      t.timestamps
    end
  end
end
