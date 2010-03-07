class BuildingsController < ApplicationController
  # GET /buildings
  # GET /buildings.xml
  def index
    @buildings = Building.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @buildings }
    end
  end

  # GET /buildings/1
  # GET /buildings/1.xml
  def show
    @building = Building.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @building }
    end
  end

  # GET /buildings/new
  # GET /buildings/new.xml
  def new
    @building = Building.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @building }
    end
  end

  # GET /buildings/1/edit
  def edit
    @building = Building.find(params[:id])
    @buildings = Building.all
  end

  # POST /buildings
  # POST /buildings.xml
  def create
    @building = Building.new(params[:building])

    respond_to do |format|
      if @building.save
        flash[:notice] = 'Building was successfully created.'
        format.html { redirect_to(@building) }
        format.xml  { render :xml => @building, :status => :created, :location => @building }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @building.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /buildings/1
  # PUT /buildings/1.xml
  def update
    @building = Building.find(params[:id])

    respond_to do |format|
      if @building.update_attributes(params[:building])
        flash[:notice] = 'Building was successfully updated.'
        format.html { redirect_to(@building) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @building.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.xml
  def destroy
    @building = Building.find(params[:id])
    @building.destroy

    respond_to do |format|
      format.html { redirect_to(buildings_url) }
      format.xml  { head :ok }
    end
  end

  def generate_table
    # buildings -> meters -> data_sets -> data_points
    return_table = "<table>"
    building = Building.find(params[:id])
    meters = Meter.find(:all, :conditions => { :building_id => building.id })
    meters.each do |m|
      list_sets = DataSet.find(:all, :conditions => { :meter_id => m.id })
      list_sets.each do |set|
        list_points = DataPoint.find(:all, :conditions => { :data_set_id => set.id })
        return_table = return_table + "<tr>"
        return_table = return_table + "<th>" + set.name + "</th>"
        list_points.each do |data_points|
          return_table = return_table + "<td>" + data_points.amount.to_s + "</td>"
        end
        return_table = return_table + "</tr>"
      end
    end
    return_table = return_table + "</table>"
    @returns = return_table
  end
end
