class GroupsController < ApplicationController

  def new
  end

  def create
    if Group.create(create_params)
      redirect_to root_path
    else
      render :new
  end

  def edit
  end

  def update
    @group = Group.params[:id]
    if @group.update(create_params)
      redirect_to root_path
    else
      render edit
    end
  end

  private
  def create_params
    params.require[:group].permit(:name)
  end
end
