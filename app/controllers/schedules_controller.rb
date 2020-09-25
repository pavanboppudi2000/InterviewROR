class SchedulesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @schedule=Schedule.all
        render json: @schedule
    end
    def new
        @schedule=Schedule.new
    end
    def show
        @schedule=Schedule.find(params[:id])
        @intee=Interviewee.where(email: @schedule.email2)
        render json: @schedule
    end
    def create
        @por=Array[]
        @schedule = Schedule.new(schedule_params)
        @inp1=Interviewer.where(email: @schedule.email1).count(:email)
        @inp2=Interviewee.where(email: @schedule.email2).count(:email)

        @eor=0
        if @inp1<1 || @inp2<1
            if @inp1<1
              @por.push( "Email 1 is not a valid Interviewer")
              @eor=@eor+1
            end
            if @inp2<1 
              @por.push( "Email 2 is not a valid Interviewee")
              @eor=@eor+1
            end          
        end        
        @inp3=Schedule.where(email1: @schedule.email1)
        @inp3.each do |inp3|
            if inp3.st < @schedule.st
                if inp3.end > @schedule.st
                    @por.push( "Interviewer is not available")
                    @eor=@eor+1
                end
            elsif inp3.st < @schedule.end
                    @por.push("Interviewer is not available ")
                    @eor=@eor+1
            end
        end
        @inp4=Schedule.where(email2: @schedule.email2)
        @inp4.each do |inp4|
            if inp4.st < @schedule.st
                if inp4.end > @schedule.st
                    @por.push("Interviewee is not available")
                    @eor=@eor+1
                end
            elsif inp4.st< @schedule.end
                 @por.push("Interviewee is not available ")
                 @eor=@eor+1
            end
        end
        if @eor>0
            @eor=@eor+1
        else
            if(@schedule.save)
                UserMailer.new_interview(@schedule).deliver_now      
                HardWorkerWorker.perform_at(@schedule.st,@schedule.email1,@schedule.st,@schedule.end)
                @por.push("Success")           
            end
        end
        render json: {"eor": @por}
    end
    def edit
       @schedule=Schedule.find(params[:id])
    end
    def update
        @por=Array[]
        @por.push("hi")
        @exschedule=Schedule.find(params[:id])
        @schedule=Schedule.new(schedule_params)       
        @inp1=Interviewer.where(email: @schedule.email1).count(:email)
        @inp2=Interviewee.where(email: @schedule.email2).count(:email)
        @eor=0
        if @inp1<1 || @inp2<1
             if @inp1<1
               @por.push("Email 1 is not a valid Interviewer")
               @eor=@eor+1
             end
             if @inp2<1 
               @por.push( "Email 2 is not a valid Interviewee ")
               @eor=@eor+1
             end          
        end        
        @poru=0
        @inp3=Schedule.where(email1: @schedule.email1)
        @inp3.each do |inp3|
            if inp3.id == @exschedule.id
                @poru=0
            else
                if inp3.st < @schedule.st
                    if inp3.end > @schedule.st
                        @por.push( "Interviewer is not available")
                        @eor=@eor+1
                    end
                elsif inp3.st < @schedule.end
                        @por.push("Interviewer is not available ")
                        @eor=@eor+1
                end
            end            
        end
        @inp4=Schedule.where(email2: @schedule.email2)
        @inp4.each do |inp4|
            if inp4.id == @exschedule.id
                @poru=0
            else
                if inp4.st < @schedule.st
                    if inp4.end > @schedule.st
                        @por.push("Interviewee is not available")
                        @eor=@eor+1
                    end
                elsif inp4.st< @schedule.end
                     @por.push( "Interviewee is not available ")
                     @eor=@eor+1
                end
            end
        end
        if @eor>0
            @eor=@eor+1
        else
            if(@exschedule.update(schedule_params))
                UserMailer.update_interview(@schedule).deliver_now
                HardWorkerWorker.perform_at(@schedule.st,@schedule.email1,@schedule.st,@schedule.end)
                @por.push("Success") 
            end
        end
        render json: {"eor": @por}
    end
    def destroy
        @schedule=Schedule.find(params[:id])
        UserMailer.delete_interview(@schedule).deliver
        @schedule.destroy
        render json: {"eor": "Deleted Scuucessfully"}
    end
    private
     def schedule_params
        params.require(:schedule).permit(:email1, :email2, :st , :end, :resume, :email)
     end
end
