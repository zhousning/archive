class DogsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!
  #authorize_resource

   
  def index
    @dog = Dog.new
   
    #@dogs = Dog.all.page( params[:page]).per( Setting.systems.per_page )
   
  end
   

  def query_all 
    items = Dog.all
   
    obj = []
    items.each do |item|
      obj << {
        #:factory => idencode(factory.id),
        :id => idencode(item.id),
       
        :name => item.name
      
      }
    end
    respond_to do |f|
      f.json{ render :json => obj.to_json}
    end
  end



   
  def show
   
    @dog = Dog.find(iddecode(params[:id]))
   
  end
   

   
  def new
    @dog = Dog.new
    
  end
   

   
  def create
    @dog = Dog.new(dog_params)
     
    if @dog.save
      redirect_to :action => :index
    else
      render :new
    end
  end
   

   
  def edit
   
    @dog = Dog.find(iddecode(params[:id]))
   
  end
   

   
  def update
   
    @dog = Dog.find(iddecode(params[:id]))
   
    if @dog.update(dog_params)
      redirect_to dog_path(idencode(@dog.id)) 
    else
      render :edit
    end
  end
   

   
  def destroy
   
    @dog = Dog.find(iddecode(params[:id]))
   
    @dog.destroy
    redirect_to :action => :index
  end
   

  

  

  
  
  

  private
    def dog_params
      params.require(:dog).permit( :name)
    end
  
  
  
end

