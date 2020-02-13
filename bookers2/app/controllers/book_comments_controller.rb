class BookCommentsController < ApplicationController
    def create
        @book_comment = BookComment.new(book_comment_params)
        @book_comment.user_id = current_user.id
        @book_comment.book_id = params[:book_id]
        if @book_comment.save
        redirect_back(fallback_location: root_path)
        else
            # puts @book_comment.errors.full_messages
        redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @book_comment = BookComment.find(params[:id])
        @book_comment.destroy
        redirect_back(fallback_location: root_path)
    end

    private
    def book_comment_params
        params.require(:book_comment).permit(:content)
    end
end
