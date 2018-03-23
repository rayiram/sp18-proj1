class PokemonsController < ApplicationController
	def new
		@pokemon = Pokemon.new
	end
	def create
		@pokemon = Pokemon.new(pokemon_params)
		@pokemon.health = 100
		@pokemon.level = 1
		@pokemon.trainer_id = current_trainer.id
		if @pokemon.save
			redirect_to trainer_path(id: @pokemon.trainer_id)
		else
			flash[:error] = @pokemon.errors.full_messages.to_sentence
		end
	end

	def capture
		#grab the id from params and set trainer to one logged in
		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer_id = current_trainer.id
		#save changes to pokemon
		@pokemon.save
		#redirect to home page
		redirect_to root_path
	end

	def damage
		#subtract 10 health
		@pokemon = Pokemon.find(params[:id])
		@pokemon.health -= 10
		@pokemon.save
		#if health<=0, destroy it
		if @pokemon.health <= 0
			#hide instead of destroy for extra credit
			@pokemon.hidden = true
			#@pokemon.destroy
		end
		#redirect to trainer's profile page
		redirect_to trainer_path(id: @pokemon.trainer_id)
	end

	def heal
		@pokemon = Pokemon.find(params[:id])
		if @pokemon.health <100
			@pokemon.health += 10
		end
		if @pokemon.health >0
			@pokemon.hidden = false
		end
		@pokemon.save
		redirect_to trainer_path(id: @pokemon.trainer_id)
	end

	private
		def pokemon_params
			params.require(:pokemon).permit(:name, :ndex)
		end
end
