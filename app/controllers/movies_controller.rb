class MoviesController < ApplicationController

  def index
    @movies = Movie.all
    #title = params[:title]
    #director = params[:director]
    # duration = get_runtime(params[:runtime_in_minutes])
    # temp1 = duration.to_i
    # binding.pry
    if params[:title] && params[:director]
      #@movies.where("title LIKE ? AND director LIKE ?", "%" + title + "%", "%" + director + "%")
      @movies = @movies.where("title LIKE ? AND director LIKE ?", "%#{params[:title]}%", "%#{params[:director]}%")

      case params[:runtime_in_minutes]
        #binding.pry
      when "Between 90 and 120 minutes"
        @movies = @movies.between_90_to_120
        # return "BETWEEN 90 and 120"
      when "Under 90 minutes"
        @movies = @movies.less_than_90
        # return "< 90"
      when "Over 120 minutes"
        @movies = @movies.greater_than_120
        # return "> 120"
      end

      # @movies = @movies.where("title LIKE ? AND director LIKE ? AND runtime_in_minutes #{duration}", title, director)
    end


  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])

  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully"
    else
      render :new
    end

  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end



  

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster, :description
      )
  end
end
