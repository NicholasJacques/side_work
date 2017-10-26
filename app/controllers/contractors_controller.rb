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

  def edit
    @contractor = Contractor.find(params[:id])
  end

  def update
    @contractor = Contractor.find(params[:id])
    if @contractor.update_attributes(contractor_params)
      redirect_to @contractor
    else
      render 'edit'
    end
  end

  private

  def contractor_params
    params.require(:contractor).permit(:first_name,
                                       :last_name,
                                       user_attributes: [:email,
                                                         :id,
                                                         :password,
                                                         :password_confirmation,
                                                         address_attributes: [:street,
                                                                              :id,
                                                                              :street2,
                                                                              :city,
                                                                              :state,
                                                                              :zip_code]])
  end
end
