class GuideController < ApplicationController
  def index
    @index = indexing
    @info = info
  end

  def show #Show whats in map should contain security to check if they can go there
    redirect_to guide_path
  end

  def new
    @all = Guide.all
  end

  def create
    @guide = Guide.new(guide_params)
    if @guide.save
      redirect_to 'new'
    else
      render 'new'
    end
  end

end

private
def indexing(binding=0)
    str = ""
      if Guide.where(bind: binding).exists?(conditions = :none)
        str += '<ul>'
        Guide.where(bind: binding).order("title ASC").each do |a|
          str += '<li><a href="#'+a.title+'" class="anchor-link">'+a.title+'</a></li>'
          str += indexing(a.id)
        end
        str += '</ul>'
      end
  return str
end

def info(binding=0,layer=0)
  str = ""
  layer += 1
  if Guide.where(bind: binding).exists?(conditions = :none)
    Guide.where(bind: binding).each do |a|
      str += '<h'+layer.to_s+' id="'+a.title+'">'+a.title+'</h'+layer.to_s+'>'
      if a.msg != nil
       str += '<p>'+a.msg+'</p>'
      end
      str += info(a.id,layer)
    end
  end
  return str
end

def guide_params
  params.require(:guide).permit(:title, :bind, :msg)
end