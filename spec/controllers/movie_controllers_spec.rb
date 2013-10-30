require 'spec_helper'

describe MoviesController do
  describe 'edit page for appropriate Movie' do
    it 'When I go to the edit page for the Movie, it should be loaded' do
      mock = mock('Movie')
      Movie.should_receive(:find).with('11').and_return(mock)
      get :edit, {:id => '11'}
      response.should be_success
    end
    it 'And I fill in "Director" with "Ridley Scott", And I press "Update Movie Info", it should save the director' do
      mock = mock('Movie')
      
      mock.stub!(:title)
      mock.stub!(:director).with("Ridley Scott")
      mock.stub!(:update_attributes!)
      
      mock2 = mock('Movie')
      
      Movie.should_receive(:find).with('11').and_return(mock)
      mock.should_receive(:update_attributes!)
      post :update, {:id => '11', :director => "Ridley Scott" }
    end
    it 'When I follow "Find Movies With Same Director", I should be on the Similar Movies page for the Movie' do
    	mock = mock('Movie')
      mock.stub!(:director).and_return('mock director')
      
      similarMocks = [mock('Movie'), mock('Movie')]
      
    	Movie.should_receive(:find).with('11').and_return(mock)
      Movie.should_receive(:find_all_by_director).with(mock.director).and_return(similarMocks)
      get :similar, {:id => '11'}
    
    end
    it 'should redirect to index if movie does not have a director' do
      mock = mock('Movie')
      mock.stub!(:director).and_return(nil)
      mock.stub!(:title).and_return('mock title')
            
      Movie.should_receive(:find).with('11').and_return(mock)
      get :similar, {:id => '11'}
      response.should redirect_to(movies_path)
    end
    it 'should be possible to create movie' do
      movie = mock('Movie')
      movie.stub!(:title)
      
      Movie.should_receive(:create!).and_return(movie)
      post :create, {:movie => movie}
      response.should redirect_to(movies_path)
    end
    it 'should be possible to destroy movie' do
      movie = mock('Movie')
      movie.stub!(:title)
      
      Movie.should_receive(:find).with('11').and_return(movie)
      movie.should_receive(:destroy)
      post :destroy, {:id => '11'}
      response.should redirect_to(movies_path)
    end
  end
end
