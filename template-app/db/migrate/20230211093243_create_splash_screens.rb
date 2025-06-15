class CreateSplashScreens < ActiveRecord::Migration[6.0]
  def change
    create_table :splash_screens do |t|
      t.string :title
    end
  end
end
