class ContractorsController < ApplicationController
  def new
    @contractor = Contractor.new
    @contractor.user = User.new
  end

  def create
    @contractor = Contractor.new(contractor_params)
    if @contractor.save
      @contractor.send_activation_email
      log_in(@contractor.user)
      flash[:success] = 'Welcome to SideWork'
      redirect_to @contractor
    else
      render 'new'
    end
  end

  def show
    @contractor = Contractor.find(params[:id])
  end

  private

  def contractor_params
    params.require(:contractor).permit(:first_name,
                                       :last_name,
                                        user_attributes: [:email,
                                                          :password,
                                                          :password_confirmation])
  end
end
