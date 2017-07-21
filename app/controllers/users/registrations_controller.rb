class Users::RegistrationsController < Devise::RegistrationsController
  # Extend default Devise gem behavior so that users signing up with the pro
  # account (plan id 2) save with a special stripe subscription function.
  # Otherwise Devise signs up user as usual.
  # super is invoking the parent Devise new method
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan.id == 2
          resource.save_with_subscription
        else
          resource.save
        end
      end
    end
  end

end