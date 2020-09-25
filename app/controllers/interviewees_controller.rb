class IntervieweesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @interviewee=Interviewee.all
        render json: @interviewee
    end
    def new
        @interviewee=Interviewee.new
    end
    def show
        @interviewee=Interviewee.find(params[:id])
    end
    def create
        @por=Array[]
        @interviewee = Interviewee.new(interviewee_params)
        @inp=Interviewer.where(email: @interviewee.email).count(:email)
        if @inp>0
            @por.push("This User can not be a Interviewee as he is an Interviewer ")  
        elsif(@interviewee.save)
            @por.push("success")
        end
        render json: {"content": @interviewee , "eor": @por}
    end
    def update
    end
    def destroy
    end
    def findmail
        @eid=Interviewee.find_by(email: params[:id]+".com")
        render json: @eid
    end
    private
     def interviewee_params
        params.require(:interviewee).permit(:email, :name, :cgpa , :clg,  :resume)
     end  
end
