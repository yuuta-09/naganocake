class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :define_customer,     except: [:index]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  private

  def define_customer
    @customer = Customer.find(params[:id])
  end
end
