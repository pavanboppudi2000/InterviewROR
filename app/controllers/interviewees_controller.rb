class IntervieweesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @interviewee=Interviewee.all
        @res={}
        @interviewee.each do |user|
            @res[user.id]=user.resume.url
        end
        render json: {"content": @interviewee, "resumes": @res}
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
        render json: {"content": @interviewee , "eor": @por ,"resume": @interviewee.resume.url}
    end
    def update
    end
    def destroy
    end
    def findmail
        @eid=Interviewee.find_by(email: params[:id]+".com")
        @res={}
        @res[@eid.id]=@eid.resume.url
        render json: {"content": @eid, "resumes": @res}
    end
    private
     def interviewee_params
        params.permit(:email, :name, :cgpa , :clg,  :resume)
     end  
end
