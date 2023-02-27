class PostsController < ApplicationController

    def index
        @posts = Post.all
        render json: @posts
    end

    def show
        @post = Post.find(params[:id])
        if @post
            render json: @post
        else
            render json: "Post not found"
        end
    end

    def create
        @post = Post.new(params.require(:post).permit(:title, :body))
        if @post.save
            render json: @post
        else
            render json: @post.errors, status: :unprocessable_entity
        end
    end

    def update
        @post = Post.find(params[:id])
        if @post.update(params.require(:post).permit(:title, :body))
            render json: @post
        else
            render json: @post.errors
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
    end
end