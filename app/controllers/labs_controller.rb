class LabsController < ApplicationController

	def index
		@labs = Lab.all
		respond_to do |format|
			format.html
		end
	end

  def edit
    @lab = Lab.find(params[:id])

    respond_to do |format|

       if @lab.update_attributes(params[:lab])
          act
          format.html {render action: "new"} #render action: "show"
          format.json { render json: @i }
        else
          format.html { render action: "edit" }
          format.json { render json: @lab.errors, status: :unprocessable_entity }
        end
      end
  end

	def new
		if @lab.object_id==4
      		@lab = Lab.new
    	else
      		@lab = Lab.find(params[:id])
      		@i = @lab.id.to_s
    	end
      
    	respond_to do |format|
    	format.html # new.html.erb
    	format.json { render json: @lab }
        end
	end

	def show
     @lab = Lab.find(params[:id])
    @i = @lab.id.to_s
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lab }
    end
	end

	def update
		@lab = Lab.find(params[:id])

		respond_to do |format|

       if @lab.update_attributes(params[:lab])
          act
        	format.html {render action: "new"} #render action: "show"
          format.json { render json: @i }
        else
       		format.html { render action: "edit" }
        	format.json { render json: @lab.errors, status: :unprocessable_entity }
      	end
    	end
	end

	def create
		 @lab = Lab.new(params[:lab])

    	respond_to do |format|
      	if @lab.save

=begin          
          @i = @lab.id.to_s
        	f = File.new("files/prog"+@i+".c","w")
        	#fl = File.new("D:\\data.txt","w")
         
       		f.print("//Following is your code: \n\n"+@lab.description.to_s)
        	f.flush

        	fl = File.expand_path(f)
        	system("gcc "+fl+" 2> files/err"+@i+".txt -o files/prog"+@i+".exe")
        	system("files\\prog"+@i+" 1> files\\output"+@i+".txt")
        	f.close 
          
        	#old_stdout = $stdout
        	#$stdout = fl
        	#$stderr = fl
        	#fl.flush
=end
          act
        	format.html {render action: "new"} #render action: "show"
        	format.json { render json: @i }
      	else
        	format.html { render action: "new" }
        	format.json { render json: @lab.errors, status: :unprocessable_entity }
      	end
    	end
	end

	def destroy
    	@lab = Lab.find(params[:id])
    	@lab.destroy

    	respond_to do |format|
      	format.html { redirect_to labs_url }
      	format.json { head :ok }
    	end
  	end

  	def destroy_all
    	@lab = Lab.find(:all)

    	@lab.each do |lab|
    		lab.destroy
    	end

    	respond_to do |format|
      	format.html { redirect_to labs_url }
      	format.json { head :ok }
    	end
  	end

    def act
      @i = @lab.id.to_s

      #if @i.exists?
        f = File.open("files/prog"+@i+".c","w")
        #fl = File.new("D:\\data.txt","w")
         
        f.print("//Following is your code: \n\n"+@lab.Description.to_s)
        f.flush

        fl = File.expand_path(f)
        @output = system("gcc "+fl+" -o files/prog"+@i+".exe")
        system("gcc "+fl+" 2> files/err"+@i+".txt")
        
        if @output.object_id==2
          system("files\\prog"+@i+" 1> files\\output"+@i+".txt")
        end
        f.close 
    end
end
