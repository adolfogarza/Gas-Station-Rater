class AddCommentIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :comment_id, :integer
    add_index :ratings, :comment_id
  end
end
