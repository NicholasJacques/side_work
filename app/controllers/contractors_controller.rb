class ContractorsController < ApplicationController
  def new
    @contractor = Contractor.new
  end

  def create
    @contractor = Contractor.new(contractor_params)
    if @contractor.save
      flash[:success] = 'Welcome to SideWork'
      redirect_to @contractor
    else
      render 'new'
    end
  end

  def show
    @contractor = Contractor.find(params[:id])
  end

  def contractor_params
    params.require(:contractor).permit(:first_name,
                                       :last_name,
                                       :email,
                                       :password,
                                       :password_confirmation)
  end
end
