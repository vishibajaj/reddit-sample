class PostsController < ApplicationController
	
	respond_to :html, :js

	def index
		@posts = Post.where(user_id: current_user.id).to_a
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id 
		@post.save

		# @post.save
		#render '/users/index'
		

		# redirect_to '/posts'
	end

	def show
		@post = Post.find(params[:id])
		@comments = @post.comments.to_a
		@post_vote_value = post_vote_count(params[:id])

		vote_value = PostVote.where(user_id: current_user.id, post_id: params[:id])[0]
		if vote_value
			p "Mihirrrrrrrrrrrrrrrrrrr"
			p vote_value.post_vote_value
			@vote_value = vote_value.post_vote_value
		end

	end


	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(post_params)
			respond_to do |format|
      			format.html { redirect_to @post }
      			format.js 
    		end
		else
			render 'edit'
		end
	end


	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		@posts = Post.where(user_id: current_user.id).to_a
		respond_to do |format|
      		format.html { redirect_to users_path }
      		format.js 
    	end
	end

	def postvote
		
		#find if user has already commeted on that post updte that value don't create a new one.

		p "current_user"
		p current_user.id
		p PostVote.find_by_post_id(params[:post_id])
		p PostVote.find_by_user_id(current_user.id)
		p "current_user end"
		if (PostVote.where(user_id: current_user.id, post_id: params[:post_id]).length > 0)
			@postvote = PostVote.where(post_id: params[:post_id], user_id: current_user.id).first
			@postvote.update(post_vote_value: params[:post_vote_value])
		
		else
			 PostVote.create(post_id: params[:post_id], user_id: current_user.id, post_vote_value: params[:post_vote_value])
		end

		# update the link for vote up and down using vote value

		@post_vote_value = post_vote_count(params[:post_id])
		
		if request.xhr?
			render json: { post_vote_value: @post_vote_value }
		end

	end

	def post_vote_count(id)

		p params
		p post_vote_up = PostVote.where(post_vote_value: true, post_id: id).length
		p post_vote_down = PostVote.where(post_vote_value: false,post_id: id).length
		post_vote_value = (post_vote_up - post_vote_down)
		p "post vote_value"
		p post_vote_value
		return post_vote_value
	end


	private

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
