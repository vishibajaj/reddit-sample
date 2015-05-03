class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
    	t.belongs_to :post
    	t.belongs_to :user

    	t.boolean :comment_vote_value

      	t.timestamps null: false
    end
  end
end
