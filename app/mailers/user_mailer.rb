class UserMailer < ApplicationMailer
    default :from => "notification@example.com"

    def new_interview(schedule)
        @schedule=schedule
        mail(:to => schedule.email1, :subject => " New Interview")
    end
    def update_interview(schedule)
        @schedule=schedule
        mail(:to => schedule.email1, :subject => "Interview Schedule Updated")
    end
    def remind_interview(schedule)
        @schedule=schedule
        mail(:to => schedule.email1, :subject => "Remainder for the Interview")
    end
    def delete_interview(schedule)
        @schedule=schedule
        mail(:to => schedule.email1, :subject => "Cancelled the Interview")
    end

end
