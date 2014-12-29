class NpcController < ApplicationController
  def index

  end

  def show
    @npc = Npc.find(params[:id])
    if @npc.nil? || @npc.location.to_s != session[:location].to_s
      redirect_to worlds_path
    end
  end

  def new
    #Npc.create(FirstName:'Deer', Race:'Deer', location: 1, mount:true)
  end

  def create
    Npc.create(FirstName:@post.FirstName, FirstName:@post.LastName, Race:@post.Race, location: session[:location], mount:true)
  end
end
