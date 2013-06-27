class Api::RegistriesController < ApiController
  # GET /registries
  # GET /registries.json
  def index
    @registries = Registry.all

    respond_to do |format|
      format.json { render json: @registries }
    end
  end

  # GET /registries/1
  # GET /registries/1.json
  def show
    @registry = Registry.find(params[:id])

    respond_to do |format|
      format.json { render json: @registry }
    end
  end

  # GET /registries/new
  # GET /registries/new.json
  def new
    @registry = Registry.new

    respond_to do |format|
      format.json { render json: @registry }
    end
  end

  # GET /registries/1/edit
  def edit
    @registry = Registry.find(params[:id])
    render json: @registry
  end

  # POST /registries
  # POST /registries.json
  def create
    @registry = Registry.new(params[:registry])

    respond_to do |format|
      if @registry.save
        format.json { render json: @registry, status: :created, location: [:api, @registry] }
      else
        format.json { render json: @registry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /registries/1
  # PUT /registries/1.json
  def update
    @registry = Registry.find(params[:id])

    respond_to do |format|
      if @registry.update_attributes(params[:registry])
        format.json { head :no_content }
      else
        format.json { render json: @registry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registries/1
  # DELETE /registries/1.json
  def destroy
    @registry = Registry.find(params[:id])
    @registry.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
