class InterviewersController < ApplicationController
    def index
        @interviewer=Interviewer.all
    end
    def new
        @interviewer=Interviewer.new
    end
    def show
        @interviewer=Interviewer.find(params[:id])
    end
    def create
        @interviewer = Interviewer.new(interviewer_params)
        @inp=Interviewee.where(email: @interviewer.email).count(:email)
        if @inp>0
            flash.alert="This user can not be a Interviewer as he is an Interviewee "
            render 'new'  
        elsif(@interviewer.save)
          redirect_to @interviewer
        else
          render 'new'
        end
    end
    private
     def interviewer_params
        params.require(:interviewer).permit(:email, :name)
     end
end
