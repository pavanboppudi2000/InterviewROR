class SchedulesController < ApplicationController
    def index
        @schedule=Schedule.all
    end
    def new
        @schedule=Schedule.new
    end
    def show
        @schedule=Schedule.find(params[:id])
        @intee=Interviewee.where(email: @schedule.email2)
    end
    def create
        @schedule = Schedule.new(schedule_params)
        @inp1=Interviewer.where(email: @schedule.email1).count(:email)
        @inp2=Interviewee.where(email: @schedule.email2).count(:email)

        @eor=0
        flash[:notice]=""
        if @inp1<1 || @inp2<1
            if @inp1<1
              flash[:notice] << "Email 1 is not a valid Interviewer <br/>"
              @eor=@eor+1
            end
            if @inp2<1 
              flash[:notice] << "Email 2 is not a valid Interviewee <br/>"
              @eor=@eor+1
            end          
        end        
        @inp3=Schedule.where(email1: @schedule.email1)
        @inp3.each do |inp3|
            if inp3.st < @schedule.st
                if inp3.end > @schedule.st
                    flash[:notice] << "Interviewer is not available <br />"
                    @eor=@eor+1
                end
            elsif inp3.st < @schedule.end
                    flash[:notice] << "Interviewer is not available <br />"
                    @eor=@eor+1
            end
        end
        @inp4=Schedule.where(email2: @schedule.email2)
        @inp4.each do |inp4|
            if inp4.st < @schedule.st
                if inp4.end > @schedule.st
                    flash[:notice] << "Interviewee is not available <br />"
                    @eor=@eor+1
                end
            elsif inp4.st< @schedule.end
                 flash[:notice] << "Interviewee is not available <br />"
                 @eor=@eor+1
            end
        end
        if @eor>0
            @eor=@eor+1
        else
            if(@schedule.save)
                UserMailer.new_interview(@schedule).deliver
                redirect_to @schedule
                return 
            end
        end
        render 'new'
    end
    def edit
       @schedule=Schedule.find(params[:id])
    end
    def update
        @exschedule=Schedule.find(params[:id])
        @schedule=Schedule.new(schedule_params)       
        @inp1=Interviewer.where(email: @schedule.email1).count(:email)
        @inp2=Interviewee.where(email: @schedule.email2).count(:email)
        @eor=0
         flash[:notice]=" <br />"
        if @inp1<1 || @inp2<1
            if @inp1<1
              flash[:notice] << "Email 1 is not a valid Interviewer <br />"
              @eor=@eor+1
            end
            if @inp2<1 
              flash[:notice] << "Email 2 is not a valid Interviewee <br />"
              @eor=@eor+1
            end          
        end        
        @por=0
        @inp3=Schedule.where(email1: @schedule.email1)
        @inp3.each do |inp3|
            if inp3.id == @exschedule.id
                @por=0
            else
                if inp3.st < @schedule.st
                    if inp3.end > @schedule.st
                        flash[:notice] << "Interviewer is not available <br />"
                        @eor=@eor+1
                    end
                elsif inp3.st < @schedule.end
                        flash[:notice] << "Interviewer is not available <br />"
                        @eor=@eor+1
                end
            end            
        end
        @inp4=Schedule.where(email2: @schedule.email2)
        @inp4.each do |inp4|
            if inp4.id == @exschedule.id
                @por=0
            else
                if inp4.st < @schedule.st
                    if inp4.end > @schedule.st
                        flash[:notice] << "Interviewee is not available <br />"
                        @eor=@eor+1
                    end
                elsif inp4.st< @schedule.end
                     flash[:notice] << "Interviewee is not available <br />"
                     @eor=@eor+1
                end
            end
        end
        if @eor>0
            @eor=@eor+1
        else
            if(@exschedule.update(schedule_params))
                UserMailer.update_interview(@schedule).deliver
                redirect_to @schedule
                return 
            end
        end
        redirect_to edit_schedule_path(@exschedule)
    end
    def destroy
        @schedule=Schedule.find(params[:id])
        UserMailer.delete_interview(@schedule).deliver
        @schedule.destroy
        redirect_to schedules_path
    end
    private
     def schedule_params
        params.require(:schedule).permit(:email1, :email2, :st , :end, :resume, :email)
     end
end
