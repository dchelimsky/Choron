class BountiesController < ApplicationController
  before_filter :require_user
  def show
    @bounty = Bounty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @auction }
    end
  end
    before_filter :require_user
  
 def require_owner
     @bounty = Bounty.find(params[:id])
     owner = @bounty.user
     unless current_user == owner
        #DEBUG
        puts '********************NOT BOUNTY OWNER'
        #store_location
        flash[:notice] = 'I\'m sorry I can\'t let you do that, Dave.'
        redirect_to(controller: 'home', action: 'chore_market')
        return false
     end
     puts '**********BOUNTY OWNER'
    end

  before_filter :require_owner, only: ['edit','destroy']
    
  # GET /bounties
  # GET /bounties.json
  def index
    @bounties = Bounty.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @bounties }
    end
  end

  # GET /bounties/new
  # GET /bounties/new.json
  def new
    @bounty = Bounty.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @bounty }
    end
  end

  # GET /bounties/1/edit
  def edit
    @bounty = Bounty.find(params[:id])
    @chore_id = @bounty.chore_id
  end

  # POST /bounties
  # POST /bounties.json
  def create
    @bounty = Bounty.new(params[:bounty])
    @chore = Chore.find(@bounty.chore_id)
    if @chore.nil?
      puts "OH GOD WHY JESUS USE VALIDATORS COME ON NOW SERRIOUSLY GUYS"
    end
    @chore.value=params[:value][:val].to_i
    @chore.save
    #TODO: Make the bounty get a user's information
    #and update the user parameter accordingly.
    @bounty.user = current_user
    respond_to do |format|
      if not @chore.nil? and @bounty.save!
        format.html { redirect_to :bounties, :notice => 'bounty was successfully created.' }
        format.json { render :json => @bounty, :status => :created, :location => @bounty }
      else
        format.html { render :action => "new", notice: 'errors creating bounty.' }
        format.json { render :json => @bounty.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bounties/1
  # PUT /bounties/1.json
  def update
    @bounty = Bounty.find(params[:id])
    @chore = Chore.find(@bounty.chore_id)
    if @chore.nil?
      puts "OH GOD WHY JESUS USE VALIDATORS COME ON NOW SERRIOUSLY GUYS"
    end
    @chore.value=params[:value][:val].to_i
    @chore.save
    respond_to do |format|
      if @bounty.save
        format.html { redirect_to @bounty, :notice => 'bounty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bounty.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bounties/1
  # DELETE /bounties/1.json
  #TODO: Remove this. Bounties should not be destroyed without a chore.
  def destroy
    @bounty = Bounty.find(params[:id])
    @bounty.destroy
    respond_to do |format|
      format.html { redirect_to controller: 'home', action: 'bounty_market' }
      format.json { head :no_content }
    end
  end
  
end
