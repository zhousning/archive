class ControlsController < ApplicationController
  layout "application_control"
  before_filter :authenticate_user!

  def index
    @factories = current_user.factories
  end

  def search
    ware = params[:ware_search]
    search = params[:search]
    if search.present?
      objs = []
      if ware == Setting.wares.water_item
        #objs = WaterItem.search search, fields: [:tag], match: :word_middle 
        objs = WaterItem.search search 
      elsif ware == Setting.wares.sewage_item
        objs = SewageItem.search search 
      elsif ware == Setting.wares.project_item
        objs = ProjectItem.search search
      elsif ware == Setting.wares.repair_part
        objs = RepairPart.search search
      elsif ware == Setting.wares.emergency
        objs = Emergency.search search
      elsif ware == Setting.wares.stuff
        objs = Stuff.search search
      end

      items = []
      objs.each do |item|
        items << {
          :name => item.name,
          :mdno => item.mdno,
          :fct  => item.fct,
          :count => item.count,
          :fctname => item.factory.name
        }
      end
    end
    respond_to do |f|
      f.json{ render :json => items.to_json}
    end
  end
      
end
