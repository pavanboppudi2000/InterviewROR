class InterviewersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @interviewer=Interviewer.all
        @por=Array[]
        @por.push("hi")
        @por.push("you are good")
        render json: {"content": @interviewer , "eor": @por}
    end
    def new
        @interviewer=Interviewer.new
    end
    def show
        @interviewer=Interviewer.find(params[:id])
    end
    def create
        @por=Array[]
        @interviewer = Interviewer.new(interviewer_params)
        @inp=Interviewee.where(email: @interviewer.email).count(:email)
        if @inp>0
            @por.push("This user can not be a Interviewer as he is an Interviewee ")  
        elsif(@interviewer.save)
            @por.push("Success")
        end
        render json: {"content": @interviewer , "eor": @por}
    end
    private
     def interviewer_params
        params.require(:interviewer).permit(:email, :name)
     end
end
