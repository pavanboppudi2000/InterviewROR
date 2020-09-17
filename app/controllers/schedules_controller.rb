class SchedulesController < ApplicationController
    def index
        @schedule=Schedule.all
    end
    def new
        @schedule=Schedule.new
    end
    def show
        @schedule=Schedule.find(params[:id])
    end
    def create
        @schedule = Schedule.new(schedule_params)
        @inp1=Interviewer.where(email: @schedule.email1).count(:email)
        @inp2=Interviewee.where(email: @schedule.email2).count(:email)
        @eor=0
        if @inp1<1 || @inp2<1
            if @inp1<1
              flash.alert="Email 1 is not a valid Interviewer"
              @eor=@eor+1
            end
            if @inp2<1 
              flash.alert="Email 2 is not a valid Interviewee"
              @eor=@eor+1
            end          
        end        
        @inp3=Schedule.where(email1: @schedule.email1)
        @inp3.each do |inp3|
            if inp3.st < @schedule.st
                if inp3.end > @schedule.st
                    flash.alert="Interviewer is not available"
                    @eor=@eor+1
                end
            elsif inp3.st < @schedule.end
                    flash.alert="Interviewer is not available"
                    @eor=@eor+1
            end
        end
        @inp4=Schedule.where(email2: @schedule.email1)
        @inp4.each do |inp4|
            if inp4.st < @schedule.st
                if inp4.end > @schedule.st
                    flash.alert="Interviewee is not available"
                    @eor=@eor+1
                end
            elsif inp4.st< @schedule.end
                 flash.alert="Interviewee is not available"
                 @eor=@eor+1
            end
        end
        if @eor>0
            @eor=@eor+1
        else
            if(@schedule.save)
                redirect_to @schedule
                return 
            end
        end
        render 'new'
    end
    private
     def schedule_params
        params.require(:schedule).permit(:email1, :email2, :st , :end)
     end
end
