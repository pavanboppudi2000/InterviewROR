class IntervieweesController < ApplicationController
    def index
        @interviewee=Interviewee.all
    end
    def new
        @interviewee=Interviewee.new
    end
    def show
        @interviewee=Interviewee.find(params[:id])
    end
    def create
        @interviewee = Interviewee.new(interviewee_params)
        @inp=Interviewer.where(email: @interviewee.email).count(:email)
        if @inp>0
            flash.alert="This User can not be a Interviewee as he is an Interviewer "
            render 'new'  
        elsif(@interviewee.save)
          redirect_to @interviewee
        else
          render 'new'
        end
    end
    def update
    end
    def destroy
    end
    private
     def interviewee_params
        params.require(:interviewee).permit(:email, :name, :cgpa , :clg)
     end  
end
