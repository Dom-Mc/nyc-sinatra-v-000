class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(params[:figure])
    unless params[:title][:name].empty?
      figure.titles << Title.create(params[:title])
    end
    unless params[:landmark][:name].empty?
      figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end
    figure.save
    redirect "/figures/#{figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = @figure.titles
    @landmarks = @figure.landmarks
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    figure = Figure.find(params[:id])
    figure.update(params[:figure])
    unless params[:title][:name].empty?
      figure.titles << Title.create(params[:title])
    end
    unless params[:landmark][:name].empty?
      figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end
    figure.save
    redirect "/figures/#{figure.id}"
  end

end
